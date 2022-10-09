# Upgrade Arch Linux
if (( $+commands[aura] )); then
  alias /autism="sudo aura -Syu && sudo aura -Au"
fi

alias world=kde-rebuild-world
alias only=kde-rebuild-only
alias reonly="kde-rebuild-only --refresh-build"
