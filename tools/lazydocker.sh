#!/bin/bash
which lazydocker && exit 1

url="https://github.com/jesseduffield/lazydocker/releases/download/
    v0.24.1/lazydocker_0.24.1_Linux_x86_64.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

mkdir lazydocker
tar xf hic -C lazydocker
rm hic

mkdir -p $HOME/.local/bin/
mv lazydocker/lazydocker $HOME/.local/bin/
rm -rf lazydocker

