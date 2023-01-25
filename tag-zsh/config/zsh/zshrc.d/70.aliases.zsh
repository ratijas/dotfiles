# Uncategorized aliases

alias NOSHIT="grep -v /locale | grep -v /man | grep -v /doc/ "

alias todo="ztodo list && any-repl --reset --split ztodo ztodo"

alias sysus="systemctl --user"

alias ee='subl "$(which e)"'
bindkey -s '\e[18~' 'e\n'  # F7

alias RTL='env LANGUAGE=ar:en_US LANG=ar_EG.UTF-8 LC_ALL='
