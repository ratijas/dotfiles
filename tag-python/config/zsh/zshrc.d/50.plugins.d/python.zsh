# Python config
[[ -r                  "${XDG_CONFIG_HOME:-$HOME/.config}/python/rc.py" ]] &&
  export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/rc.py"

# Virtual Env Wrapper
export     WORKON_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/python/virtualenv"
mkdir -p "$WORKON_HOME"
[[ -r                   /usr/bin/virtualenvwrapper.sh ]] &&
  emulate sh -c 'source /usr/bin/virtualenvwrapper.sh'
