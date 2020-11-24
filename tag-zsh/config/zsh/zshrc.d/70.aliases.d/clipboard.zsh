# Clipboard utils
if (( $+commands[xclip] )); then
  alias xclip="xclip -selection clipboard"
  alias xcopy="xclip -in"
  alias xpaste="xclip -out"
fi
