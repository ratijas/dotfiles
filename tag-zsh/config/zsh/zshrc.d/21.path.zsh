# Remove duplicates
typeset -U path
export PATH

# fix up env again after setting up the path

if   (( $+commands[subl-wait] )); then
  export VISUAL=$commands[subl-wait]
fi
export EDITOR="$VISUAL"
