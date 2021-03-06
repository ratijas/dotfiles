if (( $+commands[fzf] )); then

  if (( $+commands[bat] )); then
    alias fzfbat="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
  fi

  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --follow --type=file --color=always'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS="--ansi"
  else
    export FZF_DEFAULT_COMMAND='find -follow -type f '
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  if (( $+commands[tree] )); then
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
  fi
fi
