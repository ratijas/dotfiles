# Clipboard utils
if type xclip &> /dev/null; then
  alias xclip="xclip -selection clipboard"
  alias xcopy="xclip -in"
  alias xpaste="xclip -out"
fi
