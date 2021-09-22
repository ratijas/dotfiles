# Local weather
function weather() {
  local location=$(echo -n $@ | python -c '
import sys
from urllib.request import pathname2url

sys.stdout.write(pathname2url(sys.stdin.read()))
')
  curl http://wttr.in/"$location"
}

alias inno="weather Иннополис"
