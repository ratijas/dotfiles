import sublime
import sublime_plugin

from pathlib import Path
import subprocess
import threading
import os
import json
from dataclasses import dataclass
from typing import List, Callable, Optional


@dataclass
class ScheduledCommand:
    args: List[str]
    error: Optional[str] = None
    handler: Callable[[str], None] = None


class PlasmoidviewerBuildCommand(sublime_plugin.WindowCommand):
    encoding = 'utf-8'
    killed = False
    proc = None
    panel = None
    panel_lock = threading.Lock()
    tasks: List[ScheduledCommand] = []
    working_dir: Path = None
    last_newline = True

    def is_enabled(self, kill=False):
        # The Cancel build option should only be available
        # when the process is still running
        if kill:
            return self.proc is not None and self.proc.poll() is None
        return True

    def run(self, kill=False):
        self.terminate_proc(kill=kill)
        if kill: return

        vars = self.window.extract_variables()
        self.working_dir = Path(vars['file_path'])

        with self.panel_lock:
            self.panel = self.window.create_output_panel('exec')
            self.window.run_command('show_panel', {'panel': 'output.exec'})

        self.tasks.append(ScheduledCommand(
            args=["git", "rev-parse", "--show-toplevel"],
            error="Unable to locate git repository",
            handler=self.set_git_repo,
        ))

        threading.Thread(target=self.run_tasks).start()

    def terminate_proc(self, kill=False):
        if self.proc is not None:
            self.killed = kill
            self.proc.terminate()
            self.proc = None

    def run_tasks(self):
        while len(self.tasks) > 0:
            task = self.tasks.pop(0)
            self.queue_message("$ " + " ".join(task.args))
            if task.handler is not None:
                proc = subprocess.run(
                    task.args,
                    capture_output=True,
                    cwd=self.working_dir,
                )
                if proc.returncode != 0 and task.error is not None:
                    self.queue_message(proc.stderr.decode(self.encoding))
                    self.queue_message(task.error)
                    break
                else:
                    task.handler(proc.stdout.decode(self.encoding))
            else:
                self.proc = subprocess.Popen(
                    task.args,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    cwd=self.working_dir
                )
                self.killed = False
                self.read_handle(self.proc.stdout)
                self.proc = None

        self.tasks.clear()

    def set_git_repo(self, output: str):
        repo_path = Path(output.strip())
        repo_name = repo_path.name

        self.tasks.append(ScheduledCommand(
            args=["kdesrc-build", "--no-src", "--no-include-dependencies", repo_name],
        ))

        metadata = self.get_metadata(self.working_dir, repo_path.parent)
        if metadata is None:
            self.queue_message("Unable to locate plasmoid metadata")
            return

        plasmoid_id = metadata["KPlugin"]["Id"]
        self.tasks.append(ScheduledCommand(
            args=["env", "QT_FORCE_STDERR_LOGGING=1", "plasmoidviewer", "-a", plasmoid_id],
        ))

    def get_metadata(self, current: Path, root: Path):
        base = current.parent
        while base != root:
            metadata = base / "metadata.json"
            if metadata.is_file():
                with open(metadata) as f:
                    return json.load(f)
            base = base.parent
        return None

    def read_handle(self, handle):
        chunk_size = 2 ** 13
        out = b''
        while True:
            try:
                data = os.read(handle.fileno(), chunk_size)
                # If exactly the requested number of bytes was
                # read, there may be more data, and the current
                # data may contain part of a multibyte char
                out += data
                if len(data) == chunk_size:
                    continue
                if data == b'' and out == b'':
                    raise IOError('EOF')
                # We pass out to a function to ensure the
                # timeout gets the value of out right now,
                # rather than a future (mutated) version
                self.queue_write(out.decode(self.encoding))
                if data == b'':
                    raise IOError('EOF')
                out = b''
            except (UnicodeDecodeError) as e:
                msg = 'Error decoding output using %s - %s'
                self.queue_message(msg  % (self.encoding, str(e)))
                break
            except (IOError):
                if self.killed:
                    msg = 'Cancelled'
                else:
                    msg = 'Finished'
                self.queue_message(msg)
                break

    def queue_message(self, message):
        text = '[%s]\n' % message
        if not self.last_newline:
            text = '\n' + text
        self.queue_write(text)

    def queue_write(self, text):
        sublime.set_timeout(lambda: self.do_write(text), 1)
        self.last_newline = text.endswith('\n')

    def do_write(self, text):
        with self.panel_lock:
            self.panel.run_command('append', {'characters': text})
