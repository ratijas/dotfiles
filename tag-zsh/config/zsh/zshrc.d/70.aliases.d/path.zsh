# $PATH utils
function :path() { local ptr="${1:-PATH}"; local str="${(P)ptr}"; echo "$str" | tr ':' '\n' }
alias :p=":path"
