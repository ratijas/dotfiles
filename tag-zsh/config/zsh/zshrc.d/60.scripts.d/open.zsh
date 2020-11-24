if (( $+commands[xdg-open] )); then
  function open() {
    if [[ "$1" =~ '--help|-h' ]]; then
      echo "$0 - Smart alias for xdg-open."
      echo
      echo "Without arguments, opens current directory."
      return 1
    fi

    if [ $# = 0 ]; then
      1=.
    fi
    xdg-open "$@"
  }
fi
