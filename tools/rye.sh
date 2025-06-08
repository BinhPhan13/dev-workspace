#!/bin/sh
version=${1:-0.44.0}
pyversion=${2:-3.11.9}

if ! command -v rye; then
  curl -sSf "https://rye.astral.sh/get" |
  RYE_VERSION="$version" RYE_INSTALL_OPTION='--yes' \
  RYE_TOOLCHAIN_VERSION="cpython@$pyversion" bash || exit 1
  . $HOME/.rye/env
fi

rye self completion > rye.bash &&
install rye.bash -m 644 -Dt $HOME/.local/share/bash-completion/completions && rm rye.bash

rye config --set-bool behavior.use-uv=true
rye config --set-bool behavior.global-python=true

