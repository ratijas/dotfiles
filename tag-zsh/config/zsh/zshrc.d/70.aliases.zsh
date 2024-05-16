# Uncategorized aliases

alias NOSHIT="grep -v /locale | grep -v /man | grep -v /doc/ "

alias todo="ztodo list && any-repl --reset --split ztodo ztodo"

alias sysus="systemctl --user"

alias ee='subl "$(which e)"'
bindkey -s '\e[18~' 'e\n'  # F7
bindkey -s '\e[18;3~' 'e --build\n'  # Alt+F7
bindkey -s '\E[18;2~' 'e --run\n' # Shift+F7

alias RTL='LANGUAGE=ar:en_US LANG=ar_EG.UTF-8 LC_ALL='
alias RTL_='export LANGUAGE=ar:en_US LANG=ar_EG.UTF-8 LC_ALL='

alias RU='LANGUAGE=ru_RU:ru LANG=ru_RU LC_ALL=ru_RU.UTF-8'
alias RU_='export LANGUAGE=ru_RU:ru LANG=ru_RU LC_ALL=ru_RU.UTF-8'

alias QDS='QT_QUICK_CONTROLS_STYLE=org.kde.desktop'
alias QDS_='export QT_QUICK_CONTROLS_STYLE=org.kde.desktop'

alias QQCM='QT_QUICK_CONTROLS_MOBILE=1'
alias QQCM_='export QT_QUICK_CONTROLS_MOBILE=1'

alias QLOG='QT_FORCE_STDERR_LOGGING=1'
alias QLOG_='export QT_FORCE_STDERR_LOGGING=1'

function qscale() {
    export QT_SCALE_FACTOR=${1:-1}
}
