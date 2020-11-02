# Basic auto/tab complete

# Double tab to start navigating with arrows
zstyle ':completion:*' menu select
# Make it case insensetive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Speed up compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cache"

zmodload zsh/complist
autoload -Uz compinit && compinit
# Include hidden files
_comp_options+=(globdots)
