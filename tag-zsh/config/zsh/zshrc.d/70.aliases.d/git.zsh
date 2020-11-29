# probably did not intend to run GS
alias gs="echo 'Did you mean $(which gst)?'"

alias git-archive-zip='git archive --prefix="${PWD:t}" --format=zip --output "${PWD:t}.zip" HEAD'
