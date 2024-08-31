#!/bin/bash
curl "https://rye.astral.sh/get" |
RYE_VERSION='0.39.0' RYE_INSTALL_OPTION='--yes' \
RYE_TOOLCHAIN_VERSION='cpython@3.11.9' bash

echo "# RYE
source $HOME/.rye/env
" >> $HOME/.bashrc

source $HOME/.rye/env
mkdir -p ~/.local/share/bash-completion/completions
rye self completion > ~/.local/share/bash-completion/completions/rye.bash

