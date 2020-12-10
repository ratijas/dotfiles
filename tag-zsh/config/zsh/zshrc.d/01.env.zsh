# Keep $HOME clean
export LESSHISTFILE=/dev/null
[[ -r "$HOME/.lesshst" ]] && rm -f "$HOME/.lesshst"

export SQLITE_HISTORY=/dev/null
[[ -r "$HOME/.sqlite_history" ]] && rm -f "$HOME/.sqlite_history"

# wget
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
mkdir -p "${WGETRC:h}"
[[ -r "$HOME/.wgetrc" ]] && {
  mv -f "$HOME/.wgetrc" "$WGETRC"
} || {
  touch "$WGETRC"
}

fpath+=(
  $HOME/.config/zsh/functions
  $HOME/.config/zsh/functions/Misc
)

# Load colors definitions
autoload -U colors && colors
autoload -U more-colors && more-colors

# Prompt
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Editors
if   (( $+commands[vim] )); then
  export VISUAL=vim
elif (( $+commands[nano] )); then
  export VISUAL=nano
fi
export EDITOR="$VISUAL"

# ZSH-z plugin
ZSHZ_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh-z-data"
ZSHZ_NO_RESOLVE_SYMLINKS=1
