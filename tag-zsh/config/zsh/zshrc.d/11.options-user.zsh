# 16.2.1 Changing Directories

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt PUSHD_TO_HOME

# 16.2.2 Completion

# 16.2.3 Expansion and Globbing

setopt ALWAYS_TO_END
setopt COMPLETE_IN_WORD
# setopt WARN_CREATE_GLOBAL
# setopt WARN_NESTED_VAR  # it's too restrictive

# 16.2.4 History

setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# 16.2.5 Initialisation

# 16.2.6 Input/Output

setopt INTERACTIVE_COMMENTS
unsetopt CLOBBER
setopt CORRECT
unsetopt FLOW_CONTROL

# 16.2.7 Job Control

setopt LONG_LIST_JOBS

# 16.2.8 Prompting

setopt PROMPT_SUBST

# 16.2.9 Scripts and Functions

setopt C_BASES
setopt OCTAL_ZEROES
setopt LOCAL_OPTIONS
unsetopt MULTI_FUNC_DEF

# 16.2.10 Shell Emulation

setopt POSIX_ALIASES

# 16.2.11 Shell State

# 16.2.12 Zle
