# Uncategorized aliases

alias NOSHIT="grep -v /locale | grep -v /man | grep -v /doc/ "

alias todo="ztodo list && any-repl --reset --split ztodo ztodo"

alias sysus="systemctl --user"

function kde-rebuild-only() {
    kdesrc-build --no-src --no-include-dependencies $@
}

alias world=kde-rebuild-world

typeset -ga KDESRC_CACHED_MODULES

# List modules that can be built
function kls() {
    if [ -z "$KDESRC_CACHED_MODULES" ]; then
        KDESRC_CACHED_MODULES=($(kdesrc-build --list-build --no-src | head -n -1 | cut -d' ' -f 3))
        if [ $? -ne 0 ]; then
            return 1
        fi
    fi

    if [ "$1" != "-q" ]; then
        print -l $KDESRC_CACHED_MODULES
    fi
}

function kdesrc-query-global() {
    local -a KDESRC_PARAMS=(
        prefix
        kdedir
        source-dir
        build-dir
    )
    local param="$1"
    if [ -z "$param" ]; then
        param=$(print -l $KDESRC_PARAMS | fzf)
        if [ $? -ne 0 ]; then
            return 1
        fi
    fi
    local value
    value=$(grep "^\s*$param" ~/.config/kdesrc-buildrc | awk '{ print $2 }')
    if [ $? -ne 0 ]; then
        return 1
    fi
    echo $value
}

# Choose kdesrc-build interactively
function kmod() {
    # Ensure cache is loaded
    kls -q

    local module="$1"
    if [ -z "$module" ]; then
        module=$(kls | fzf)
        if [ $? -ne 0 ]; then
            return 1
        fi
    fi

    if (( ${KDESRC_CACHED_MODULES[(Ie)$module]} == 0 )); then
        echo "kmod: Module not found: $module" >&2
        return 1
    fi

    echo "$module"
}

# Navigate to source directory
function kcd() {
    # Ensure cache is loaded
    kls -q

    local module="$1"
    module=$(kmod)
    if [ $? -ne 0 ]; then return 1; fi

    local srcdir
    srcdir=$(kdesrc-query-global source-dir)
    if [ $? -ne 0 ]; then return 1; fi
    srcdir=${srcdir/\~/$HOME}  # shell doesn't provide a simpler way

    local builddir
    builddir=$(kdesrc-query-global build-dir)
    if [ $? -ne 0 ]; then return 1; fi
    builddir=${builddir/\~/$HOME}  # shell doesn't provide a simpler way

    local target
    target=$(
        fd -d 3 -t d "$module$" \
            "$srcdir" \
            "$srcdir/kde/kdegraphics/libs/" \
            "$builddir" \
            |
        grep -v log |
        fzf
    )
    if [ $? -ne 0 -o ! -d "$target" ]; then return 1; fi

    cd "$target"
}


# Mnemonics:

# Build
alias kb="kdesrc-build --no-include-dependencies --no-src"
# Refresh
alias kr="kdesrc-build --no-include-dependencies --no-src --refresh-build"
# Source
alias ks="kdesrc-build --no-include-dependencies"

# Build Plasma Framworks
alias kbpf="kb plasma-frameworks"
# Build Plasma Workspace
alias kbpf="kb plasma-workspace"
# Build Plasma Desktop
alias kbpf="kb plasma-desktop"
# Build Plasma
alias kbp="kb plasma-frameworks plasma-workspace plasma-desktop"
# Build Plasma & Restart
function kbpr() {
    kb plasma-frameworks plasma-workspace plasma-desktop $@
    fix-plasma
}

# KF6
alias k6="kdesrc-build --rc-file=$HOME/.config/kf6.kdesrc-buildrc"
# Build
alias kb6="k6 --no-include-dependencies --no-src"
# Refresh
alias kr6="k6 --no-include-dependencies --no-src --refresh-build"
# Source
alias ks6="k6 --no-include-dependencies"

