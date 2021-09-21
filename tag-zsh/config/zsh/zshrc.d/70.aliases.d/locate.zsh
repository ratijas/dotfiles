# mlocate/plocate madness
if (( ! $+commands[locate] && $+commands[plocate] )); then
  alias locate=plocate
fi
