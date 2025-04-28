#!/bin/bash
which dust && exit 1

url="https://github.com/bootandy/dust/releases/download/
    v1.2.0/dust-v1.2.0-x86_64-unknown-linux-musl.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

tar xf hic
rm hic
dir="dust-v1.2.0-x86_64-unknown-linux-musl"

mkdir -p $HOME/.local/bin/
cp $dir/dust $HOME/.local/bin/

rm -rf $dir

