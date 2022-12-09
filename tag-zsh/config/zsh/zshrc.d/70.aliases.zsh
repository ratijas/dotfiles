# Uncategorized aliases

alias NOSHIT="grep -v /locale | grep -v /man | grep -v /doc/ "

alias todo="ztodo list && any-repl --reset --split ztodo ztodo"

alias sysus="systemctl --user"

alias ee='subl "$(which e)"'
bindkey -s '^G' 'e\n'
