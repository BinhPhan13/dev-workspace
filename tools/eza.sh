#!/bin/bash
which eza && exit 1

url="https://github.com/eza-community/eza/releases/download/
    v0.19.0/eza_x86_64-unknown-linux-gnu.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

mkdir -p $HOME/.local/bin/
tar xf hic -C $HOME/.local/bin/
rm hic

mkdir -p $HOME/.local/share/man/man1/
dir=$(dirname $0)
cp $dir/eza.1 $HOME/.local/share/man/man1/

