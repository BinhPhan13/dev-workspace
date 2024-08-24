#!/bin/bash
url="https://github.com/neovim/neovim/releases/download/
    v0.9.5/nvim-linux64.tar.gz"
curl -L ${url//[[:space:]]/} -o hic &&

mkdir -p $HOME/.local/bin/

rm -rf $HOME/.local/nvim-linux64/
tar xf hic -C $HOME/.local/
rm hic

rm -f $HOME/.local/bin/nvim
ln -s $HOME/.local/{nvim-linux64,}/bin/nvim

rm -rf $HOME/.config/nvim/
cp -r ${0%/*}/../.config/nvim/ $HOME/.config/

