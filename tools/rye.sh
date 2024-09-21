#!/bin/bash
which rye && exit 1

curl "https://rye.astral.sh/get" |
RYE_VERSION='0.39.0' RYE_INSTALL_OPTION='--yes' \
RYE_TOOLCHAIN_VERSION='cpython@3.11.9' bash || exit 1

cmd='source $HOME/.rye/env'
grep -q "$cmd" $HOME/.bashrc ||
echo "# RYE
$cmd
" >> $HOME/.bashrc

eval $cmd
mkdir -p $HOME/.local/share/bash-completion/completions/
rye self completion > $HOME/.local/share/bash-completion/completions/rye.bash

rye config --set-bool behavior.use-uv=true
rye config --set-bool behavior.global-python=true

