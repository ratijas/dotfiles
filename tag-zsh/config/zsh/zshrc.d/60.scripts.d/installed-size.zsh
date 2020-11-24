if (( $+commands[expac] )); then
  function installed-size() {
    if [[ "$1" =~ '--help|-h' ]]; then
      echo "$0 - report total size of all packages installed on the"
      echo '  Arch Linux system in human-readable format.'
      echo
      echo 'Usage: installed-size [units]'
      echo '  where units are one of: B, K, M, G, T, P, E, Z, Y.'
      echo '                          default is G.'
      echo
      echo 'See also: expac(1).'
      return 1
    fi
    local units="${1:-G}"
    expac -H "$units" '%m' | awk '{sum += $1} END {print sum, $2}'
  }
fi
