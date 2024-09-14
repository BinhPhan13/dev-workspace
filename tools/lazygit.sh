#!/bin/bash
which lazygit && exit 1

url="https://github.com/jesseduffield/lazygit/releases/download/
    v0.43.1/lazygit_0.43.1_Linux_x86_64.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

mkdir lazygit
tar xf hic -C lazygit
rm hic

mkdir -p $HOME/.local/bin/
mv lazygit/lazygit $HOME/.local/bin/
rm -rf lazygit

