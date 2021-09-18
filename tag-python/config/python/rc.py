import binascii
from glob import glob
import itertools
import os
import random
import re
import struct
import sys
import time
import types
from pprint import pprint


def _CommandLineCaller(cls):
    """Class decorator to allow call instances with '/' operator."""
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


# complete and history
def complete_and_history():
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

complete_and_history()
del complete_and_history


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
class _DisplayHook:
    def __init__(self):
        self.bases = True

    def __call__(self, value):
        if value is None:
            return

        try:
            import __builtin__
            __builtin__._ = value
        except ImportError:
            __builtins__._ = value

        printed = False
        if self.bases:
            printed = self.print(value)
        if not printed:
            pprint(value)

    @classmethod
    def print(cls, value) -> bool:
        if isinstance(value, int):
            cls.print_int(value)
        elif isinstance(value, float):
            cls.print_float(value)
        else:
            return False
        return True

    @classmethod
    def print_int(cls, value: int):
        print("dec: %d" % value)
        print("hex: %s" % hex(value))
        print("oct: %s" % oct(value))
        print("bin: %s" % bin(value))
        try:
            print("chr: %r" % chr(value))
        except (OverflowError, ValueError):
            print("chr: (error)")

    @classmethod
    def print_float(cls, value: float):
        pack = struct.pack('d', value)

        print("dec: %s" % str(value))
        print("hex: %s" % binascii.b2a_hex(pack, ' ', 2).decode('ascii'))
        print("bin: %s" % cls.b2a_bin(pack, ' '))

    @classmethod
    def b2a_bin(cls, value: bytes, sep: str = '', bytes_per_sep: int = 1) -> str:
        b2a_byte = lambda x: bin(x)[2:].ljust(8, '0') if 0 <= x <= 255 else '(error!)'

        # https://docs.python.org/3/library/itertools.html#itertools-recipes
        def grouper(iterable, n, fillvalue=None):
            "Collect data into fixed-length chunks or blocks"
            # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx"
            args = [iter(iterable)] * n
            return itertools.zip_longest(*args, fillvalue=fillvalue)

        return sep.join(
            ''.join(chunk)
            for chunk in grouper((b2a_byte(b) for b in value), bytes_per_sep)
        )


sys.displayhook = _DisplayHook()
del _DisplayHook

@_CommandLineCaller
class _baseon(object):
    def __repr__(self):
        sys.displayhook.bases = True
        return 'Numbers will be printed in alternative bases'

baseon = _baseon = _baseon()

@_CommandLineCaller
class _baseoff(object):
    def __repr__(self):
        sys.displayhook.bases = False
        return 'Numbers will be printed only in decimal'

baseoff = _baseoff = _baseoff()
