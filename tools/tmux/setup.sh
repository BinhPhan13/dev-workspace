#!/bin/bash
dir=$(dirname $0)

mkdir -p $HOME/.local/bin/
cp $dir/tmux $HOME/.local/bin/

mkdir -p $HOME/.local/share/man/man1/
cp $dir/tmux.1 $HOME/.local/share/man/man1/

if ! [ -d $HOME/.local/tmux-plugins/ ]; then
git clone https://github.com/tmux-plugins/tpm $HOME/.local/tmux-plugins/
fi

