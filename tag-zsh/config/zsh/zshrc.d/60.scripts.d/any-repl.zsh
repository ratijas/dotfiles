function any-repl () {
  if [[ $# < 2 ]]; then
    echo "$0 - wrap any command in REPL-style interface"
    echo ""
    echo "Usage: $0 prompt cmd [arg ...]"
    echo "    prompt        - Analogue to \$PS1"
    echo "    cmd [arg ...] - Command to run and args to pass. User's input will be passed as the last argument."
    return 1
  fi
  typeset prompt=$1
  shift
  typeset -a cmdargs=($@)
  typeset -g query
  typeset query_prompt='%%%F{green}'$prompt'%f '

  while vared -p "$query_prompt" -e -c query; do
    if [[ "$query" =~ '^\s*$' ]]; then
      query=""
    else
      $cmdargs $query
    fi
  done
}
