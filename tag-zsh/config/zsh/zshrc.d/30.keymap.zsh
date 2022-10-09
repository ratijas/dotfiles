# Using emacs mode
bindkey -A emacs main

# Map Backspace and Delete as in GUI text editor
bindkey '^[[3~'     delete-char  # Delete

# Ctrl+keys navigate whole words
bindkey '^[[1;5D'  backward-word # Ctrl+Left
bindkey '^[[1;5C'  forward-word  # Ctrl+Right
bindkey '^H' backward-kill-word  # Ctrl+Backspace
bindkey '^[[3;5~'   delete-word  # Ctrl+Delete

# Alt+keys navigate sub-words
bindkey '^[[1;3D'      vi-backward-word      # Alt+Left
bindkey '^[[1;3C'      vi-forward-word       # Alt+Right
bindkey '^[^?'         vi-backward-kill-word # Alt+Backspace
bindkey '^[[3;3~'      delete-word           # Alt+Delete (vi variant does not exist)

# Home, End, PgUp, PgDn
bindkey '^[[1~' beginning-of-line  # Home
bindkey '^[[H'  beginning-of-line  # Home
bindkey '^[[F'  end-of-line        # End
bindkey '^[[4~' end-of-line        # End
bindkey '^[[5~' up-history         # PgUp
bindkey '^[[6~' down-history       # PgDn

bindkey '^[[23~' beep              # F11

# Zsh help files and man pages
(( $+aliases[run-help] )) && unalias run-help
autoload run-help
bindkey '\eh' run-help  # Alt+h

# Complete on tab
bindkey '^i' expand-or-complete-prefix

# History scrolling on multiline boundaries
# bindkey '^[[A' up-line-or-search  # Up
# bindkey '^[[B' down-line-or-search   # Down

# History prefix mathing
bindkey '^[[A' history-beginning-search-backward  # Up
bindkey '^[[B' history-beginning-search-forward   # Down

# File system navigation
cd-back() {
    popd
    zle reset-prompt
}
cd-parent() {
    pushd ..
    zle reset-prompt
}
zle -N                 cd-parent
zle -N                 cd-back
bindkey '^[[1;3A'      cd-parent  # Alt+Up
