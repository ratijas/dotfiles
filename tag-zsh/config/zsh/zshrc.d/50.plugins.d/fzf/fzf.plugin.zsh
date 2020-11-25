if (( $+commands[fzf] )); then

  if (( $+commands[bat] )); then
    alias fzfbat="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
  fi

  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type file --color=always'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS="--ansi"
  else
    export FZF_DEFAULT_COMMAND='find -type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  if (( $+commands[tree] )); then
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
  fi

  if [[ -d /usr/share/fzf ]]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
  fi
fi
