# Uncategorized aliases

alias NOSHIT="grep -v /locale | grep -v /man | grep -v /doc/ "

alias todo="ztodo list && any-repl --reset --split ztodo ztodo"

alias sysus="systemctl --user"

alias ee='subl "$(which e)"'
bindkey -s '\e[18~' 'e\n'  # F7

alias RTL='LANGUAGE=ar:en_US LANG=ar_EG.UTF-8 LC_ALL='
alias RTL_='export LANGUAGE=ar:en_US LANG=ar_EG.UTF-8 LC_ALL='

alias RU='LANGUAGE=ru_RU:ru LANG=ru_RU LC_ALL=ru_RU.UTF-8'
alias RU_='export LANGUAGE=ru_RU:ru LANG=ru_RU LC_ALL=ru_RU.UTF-8'

alias QDS='QT_QUICK_CONTROLS_STYLE=org.kde.desktop'
alias QDS_='export QT_QUICK_CONTROLS_STYLE=org.kde.desktop'
