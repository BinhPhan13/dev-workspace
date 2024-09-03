#!/bin/bash
which fd && exit 1

url="https://github.com/sharkdp/fd/releases/download/
    v10.1.0/fd-v10.1.0-x86_64-unknown-linux-musl.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

tar xf hic
rm hic
dir="fd-v10.1.0-x86_64-unknown-linux-musl"

mkdir -p $HOME/.local/bin/
cp $dir/fd $HOME/.local/bin/

mkdir -p $HOME/.local/share/man/man1/
cp $dir/fd.1 $HOME/.local/share/man/man1/

mkdir -p $HOME/.local/share/bash-completion/completions/
cp $dir/autocomplete/fd.bash $HOME/.local/share/bash-completion/completions/

