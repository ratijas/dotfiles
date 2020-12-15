# Traversing to the mount point
if [[ -d /var/run/media ]]; then
  export mnt="/Volumes"
  function mnt() { cd "$mnt" ;}
fi

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Borrowed from oh-my-zsh/lib/functions.zsh
function take() {
  mkdir -p $@ && cd ${@:$#}
}
