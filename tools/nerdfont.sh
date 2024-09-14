#!/bin/bash

url="https://github.com/ryanoasis/nerd-fonts/releases/download/
    v3.2.1/DroidSansMono.tar.xz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

mkdir font/
tar xf hic -C font/
rm hic

mkdir -p $HOME/.fonts/
mv font/*Font-Regular.otf $HOME/.fonts/
rm -rf font/

