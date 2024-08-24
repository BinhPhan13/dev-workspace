#!/bin/bash
url="https://github.com/eza-community/eza/releases/download/
    v0.19.0/eza_x86_64-unknown-linux-gnu.tar.gz"
curl -L ${url//[[:space:]]/} -o hic &&

mkdir -p $HOME/.local/bin/
tar xf hic -C $HOME/.local/bin/
rm hic

