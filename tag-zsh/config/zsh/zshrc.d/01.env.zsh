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

fpath=(
  $HOME/.config/zsh/functions
  $HOME/.config/zsh/functions/Misc
  /usr/local/kde/usr/share/zsh/site-functions
  $fpath
)

# Mark all function files for autoloading.
#
# Glob Qualifiers (.) and (@r) match plain files and readable symbolic links;
# (N) sets the NULL_GLOB option for the current pattern, so it doesn't print
# an error for non-existent and empty directories; Parameter expansion flag
# (:t) exands to filename only.
for dir in $fpath; do
  local scripts=($dir/*(N.,@r:t))
  # We don't want to call autoload with an empty list, as it will just print
  # all functions marked for autoloading instead.
  if [[ ${#scripts} -ne 0 ]]; then
    autoload -Uz "${scripts[@]}"
  fi
done
unset dir
unset scripts

# Load colors definitions
colors && more-colors

# Prompt
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Editors
if   (( $+commands[vim] )); then
  export VISUAL=vim
elif (( $+commands[nano] )); then
  export VISUAL=nano
fi
if   (( $+commands[subl] )); then
  export VISUAL=subl-wait
fi
export EDITOR="$VISUAL"

# ZSH-z plugin
ZSHZ_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh-z-data"
ZSHZ_NO_RESOLVE_SYMLINKS=1
