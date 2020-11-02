LFCD="/usr/share/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
  emulate sh -c 'source "$LFCD"'
  alias cdlf=lfcd
  bindkey -s '^o' 'lfcd\n'
fi
unset LFCD
