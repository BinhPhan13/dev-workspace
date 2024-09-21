#!/bin/bash
[[ -d $HOME/.local/nvim-linux64/ ]] && exit 1

url="https://github.com/neovim/neovim/releases/download/
    v0.9.5/nvim-linux64.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

mkdir -p $HOME/.local/
tar xf hic -C $HOME/.local/
rm hic

mkdir -p $HOME/.local/bin/
rm -f $HOME/.local/bin/nvim
ln -s $HOME/.local/{nvim-linux64,}/bin/nvim

mkdir -p $HOME/.config/
rm -rf $HOME/.config/nvim/

dir=$(dirname $0)
cp -r $dir/../.config/nvim/ $HOME/.config/

