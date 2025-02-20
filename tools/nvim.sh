#!/bin/bash
if [[ -d $HOME/.local/nvim-linux64/ ]]; then echo "existed !" ; exit 1; fi

url="https://github.com/neovim/neovim/releases/download/
    v0.10.4/nvim-linux-x86_64.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

mkdir -p $HOME/.local/
tar xf hic -C $HOME/.local/
rm hic

mkdir -p $HOME/.local/bin/
ln -sf $HOME/.local/nvim-linux-x86_64/bin/nvim $HOME/.local/bin/vi

