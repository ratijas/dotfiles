function urldecode() {
  python -c "
import sys
from urllib.parse import unquote_plus as up

sys.stdout.write(up(sys.stdin.read()))
"
}
