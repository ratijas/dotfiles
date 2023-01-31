# kdesrc-build related utilities

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
  if [ -z "$module" ]; then
    module=$(kmod)
    if [ $? -ne 0 ]; then return 1; fi
  fi

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
function _kcd() {
  local expl
  kls -q
  _wanted modules expl 'module' \
    compadd -a KDESRC_CACHED_MODULES
}
compdef _kcd kcd

# p10k integration
prompt_kf_version() {
  local ver=5
  local fg="white"
  local bg="magenta"
  if (( $LD_LIBRARY_PATH[(I)/usr/local/kde6/lib] )) ; then
    ver=6
    bg=darkseagreen
  fi

  _p9k_prompt_segment "$0" "$bg" "$fg" 'VCS_BRANCH_ICON' 0 '' "KF$ver"
}

_p9k_prompt_kf_init() {
  typeset -g "_p9k__segment_cond_${_p9k__prompt_side}[_p9k__segment_index]"='$commands[kdesrc-build]'
}

alias kf6="source kf6.env"
alias kcd6="cd $HOME/kde/src-kf6"

# Mnemonics:

alias pv="plasmoidviewer -a"

# Build
alias kb="kdesrc-build --no-include-dependencies --no-src"
# ReBuild
alias krb="kdesrc-build --no-include-dependencies --no-src --refresh-build"
# Source
alias ks="kdesrc-build --no-include-dependencies --src-only"
# Source & Build
alias ksb="kdesrc-build --no-include-dependencies"
# Run
alias kr="kdesrc-run"

# Build Plasma Framworks
alias kbpf="kb plasma-framework"
# Build Plasma Workspace
alias kbpw="kb plasma-workspace"
# Build Plasma Desktop
alias kbpd="kb plasma-desktop"
# Build Plasma
alias kbp="kb plasma-framework plasma-workspace plasma-desktop"
# Build Plasma & Restart
function kbpr() {
  kb plasma-framework plasma-workspace plasma-desktop $@
  fix-plasma
}
compdef kbpr=kdesrc-build
compdef kde-rebuild-world=kdesrc-build

# KScreen stuff
alias kd="kscreen-doctor"
alias kdo="kscreen-doctor -o"
function ksc() {
  kb --stop-on-failure plasma-wayland-protocols libkscreen kscreen kwin plasma-workspace
  systemctl --user restart plasma-kscreen.service plasma-kded.service plasma-plasmashell.service plasma-kwin_x11.service
  kcmshell5 kcm_kscreen
}
function kscreen-aoc-setup-x11() {
  kscreen-doctor output.DP-3.enable output.DP-3.mode.2560x1440@120 output.DP-3.position.0,0 output.DP-2.enable output.DP-2.position.2560,360
}

# KF6
alias k6="kdesrc-build --rc-file=$HOME/.config/kf6.kdesrc-buildrc"
# Source
alias ks6="k6 --no-include-dependencies --src-only"
# Build
alias kb6="k6 --no-include-dependencies --no-src"
# ReBuild
alias krb6="k6 --no-include-dependencies --no-src --refresh-build"
# There's no --rc-file= support in kdesrc-run?
# Run
alias kr6="k6 --run"
