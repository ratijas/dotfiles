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
}

# Load colors definitions
autoload -U colors && colors

# Prompt
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Editors
if   (( $+commands[vim] )); then
  export VISUAL=vim
elif (( $+commands[nano] )); then
  export VISUAL=nano
fi
export EDITOR="$VISUAL"
