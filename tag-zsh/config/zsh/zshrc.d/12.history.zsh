HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/zsh"

# XXX: One-time migration
if [[ -r ~/.zsh_history ]]; then
  mv ~/.zsh_history "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
fi
