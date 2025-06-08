#!/bin/sh
command -v bat && exit 1

version=${1:-v0.25.0}
dir="bat-$version-x86_64-unknown-linux-musl"
url="https://github.com/sharkdp/bat/releases/download/
    $version/$dir.tar.gz"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

tar xf hic && rm hic
install $dir/bat -Dt $HOME/.local/bin
install $dir/bat.1 -m 644 -Dt $HOME/.local/share/man/man1
install $dir/autocomplete/bat.bash -m 644 -Dt $HOME/.local/share/bash-completion/completions
rm -rf $dir

