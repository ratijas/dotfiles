() {
  local LFCD
  for LFCD in /usr/share/lf/lfcd.sh /etc/profile.d/lfcd.sh ; do
    if [ -r "$LFCD" ]; then
      emulate sh -c 'source "$LFCD"'
      break
    fi
  done

  alias cdlf=lfcd
  bindkey -s '^o' 'lfcd\n'
}
