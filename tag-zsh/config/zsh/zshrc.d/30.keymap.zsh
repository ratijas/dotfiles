# Using emacs mode
bindkey -A emacs main

# Map Backspace and Delete as in GUI text editor
bindkey '^H' backward-kill-word  # Ctrl+Backspace
bindkey '^[[3~'     delete-char  # Delete
bindkey '^[[3;5~'   delete-word  # Ctrl+Delete

# Map Ctrl+Arrows to navigate words
bindkey '^[[1;5D'  vi-backward-word
bindkey '^[[1;5C'  vi-forward-word

# Home, End, PgUp, PgDn
bindkey '^[[H'  beginning-of-line  # Home
bindkey '^[[F'  end-of-line        # End
bindkey '^[[5~' up-history         # PgUp
bindkey '^[[6~' down-history       # PgDn

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
bindkey '^[[1;3D'      cd-back    # Alt+Left
