() {
  local _location _locations=(
    "/usr/share/zsh/plugins/zsh-syntax-highlighting"
    "/usr/share/zsh-syntax-highlighting"
  )
  for _location in $_locations; do
    if [[ -r "$_location/zsh-syntax-highlighting.zsh" ]]; then
      source "$_location/zsh-syntax-highlighting.zsh"
      break
    fi
  done
}
