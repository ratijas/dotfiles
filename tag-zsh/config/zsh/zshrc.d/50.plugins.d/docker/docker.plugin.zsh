# Enable short-options stacking. Per discussions at
# - https://github.com/docker/cli/issues/993
# - https://github.com/docker/cli/pull/788
# - https://github.com/moby/moby/pull/17124
# - https://github.com/moby/moby/pull/17396
# - https://github.com/ohmyzsh/ohmyzsh/issues/6710
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
