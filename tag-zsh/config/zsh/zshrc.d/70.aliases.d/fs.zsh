# Traversing to the mount point
if [[ -d /var/run/media ]]; then
  export mnt="/var/run/media/$USER"
  function mnt() { cd "$mnt" ;}
fi

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
