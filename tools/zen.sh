#!/bin/bash
[[ -d $HOME/.local/zen-browser/ ]] && exit 1

url="https://github.com/zen-browser/desktop/releases/download/
    1.0.0-a.37/zen.linux-generic.tar.bz2"
curl -L ${url//[[:space:]]/} -o hic || exit 1

mkdir -p $HOME/.local/
tar xf hic -C $HOME/.local/
mv $HOME/.local/zen{,-browser}
rm hic

ln -s $HOME/.local/{zen-browser,bin}/zen

