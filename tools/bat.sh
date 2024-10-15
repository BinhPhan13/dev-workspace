#!/bin/bash
which bat && exit 1

url="https://github.com/sharkdp/bat/releases/download/
    v0.24.0/bat-v0.24.0-x86_64-unknown-linux-musl.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

tar xf hic
rm hic
dir="bat-v0.24.0-x86_64-unknown-linux-musl"

mkdir -p $HOME/.local/bin/
cp $dir/bat $HOME/.local/bin/

mkdir -p $HOME/.local/share/man/man1/
cp $dir/bat.1 $HOME/.local/share/man/man1/

mkdir -p $HOME/.local/share/bash-completion/completions/
cp $dir/autocomplete/bat.bash $HOME/.local/share/bash-completion/completions/

rm -rf $dir

