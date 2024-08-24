#!/bin/bash
url="https://github.com/junegunn/fzf/releases/download/
    v0.54.3/fzf-0.54.3-linux_amd64.tar.gz"
curl -L ${url//[[:space:]]/} -o hic &&

mkdir -p $HOME/.local/bin/
tar xf hic -C $HOME/.local/bin/
rm hic
