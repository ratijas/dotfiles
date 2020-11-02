from __future__ import division, print_function

import os, sys, types
import time, random
import re
from glob import glob
from pprint import pprint


def _CommandLineCaller(cls):
    """class decorator to allow call instances with '/' operator."""
    convert = {
        '__call__': ['__div__',
                     '__rdiv__',
                     '__truediv__',
                     '__rtruediv__'],
    }
    for root, funcs in convert.items():
        for fn_name in funcs:
            setattr(cls, fn_name, getattr(cls, root, None))
    if not getattr(cls, '__repr__', None) is not getattr(object, '__repr__', None):
        setattr(cls, '__repr__', lambda self: repr(self()))
    return cls


@_CommandLineCaller
class _h(object):
    def __init__(self, *argv, **kwargv):
        import pydoc
        self.pydoc = pydoc

    def __repr__(self):
        return repr(help) + "\n" +\
                "Shortcut: h(), h(object), h/object, object/h (beware of __rdiv__ implemented by object)"

    def __call__(self, *argv, **kwargv):
        self.pydoc.help(*argv, **kwargv)

h = _h = _h()


@_CommandLineCaller
class _d(object):
    def __call__(self, *argv, **kwargv):
        if len(argv) + len(list(kwargv.keys())) == 0:
            return sorted(globals().keys())
        return dir(*argv, **kwargv)

d = _d = _d()


# autocomplete and history
def autocomplete_and_history():
    import atexit
    import os
    import readline
    import rlcompleter

    readline.parse_and_bind('tab: complete')

    history_path = os.path.expanduser("~/.pyhistory")

    def save_history(history_path=history_path):
        import readline
        readline.write_history_file(history_path)

    if os.path.exists(history_path):
        readline.read_history_file(history_path)

    atexit.register(save_history)
    del atexit, os, readline, rlcompleter, save_history, history_path
autocomplete_and_history()
del autocomplete_and_history


@_CommandLineCaller
class _ls(object):
    def __repr__(self):
        pprint(os.listdir("."))
        return ''

    def __call__(self, path="."):
        try:
            return os.listdir(path)
        except OSError:
            candidates = glob.glob(path + "/")
            if len(candidates) == 0:
                candidates = glob.glob(path + "*/")
                if len(candidates) == 0:
                    os.listdir(path)  # let it raise an error
            if len(candidates) == 1:
                dir = candidates[0]
                return os.listdir(dir)
            else:
                raise OSError("[ls error] more than one directory matches")

ls = _ls = _ls()


@_CommandLineCaller
class _cd(object):
    def __init__(self):
        import os
        self.cd = os.chdir

    def __repr__(self):
        return 'usage: cd("path") | cd/"path"'

    def __call__(self, path):
        try:
            self.cd(path)
        except OSError:
            import glob
            candidates = glob.glob(path + "/")
            if len(candidates) == 0:
                candidates = glob.glob(path + "*/")
                if len(candidates) == 0:
                    self.cd(path)  # let it raise an error
            if len(candidates) == 1:
                dir = candidates[0]
                self.cd(dir)
                print(dir.rstrip("/"))
            else:
                raise OSError("[cd error] more than one directory matches")

cd = _cd = _cd()


# Enable Pretty Printing for stdout
###################################
def displayhook(value):
    if value is not None:
        try:
            import __builtin__
            __builtin__._ = value
        except ImportError:
            __builtins__._ = value
        pprint(value)

sys.displayhook = displayhook
del displayhook