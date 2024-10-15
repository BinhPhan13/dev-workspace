#!/bin/bash
which rg && exit 1

url="https://github.com/BurntSushi/ripgrep/releases/download/
    14.0.2/ripgrep-14.0.2-x86_64-unknown-linux-musl.tar.gz"
curl -L ${url//[[:space:]]/} -o hic || exit 1

tar xf hic
rm hic
dir="ripgrep-14.0.2-x86_64-unknown-linux-musl"

mkdir -p $HOME/.local/bin/
cp $dir/rg $HOME/.local/bin/

mkdir -p $HOME/.local/share/man/man1/
cp $dir/doc/rg.1 $HOME/.local/share/man/man1/

mkdir -p $HOME/.local/share/bash-completion/completions/
cp $dir/complete/rg.bash $HOME/.local/share/bash-completion/completions/

rm -rf $dir

