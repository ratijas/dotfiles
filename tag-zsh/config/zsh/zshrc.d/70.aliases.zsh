# Uncategorized aliases

alias NOSHIT="grep -v /locale | grep -v /man | grep -v /doc/ "

alias todo="ztodo list && any-repl --reset --split ztodo ztodo"

function kde-rebuild-only() {
    kdesrc-build --no-src --no-include-dependencies $@
}
