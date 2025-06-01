#!/bin/sh
command -v eza && exit 1

version=${1:-v0.20.24}
url="https://github.com/eza-community/eza/releases/download/
    $version/eza_x86_64-unknown-linux-musl.tar.gz"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

mkdir -p $HOME/.local/bin
tar xf hic -C $HOME/.local/bin && rm hic

