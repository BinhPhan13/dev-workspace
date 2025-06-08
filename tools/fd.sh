#!/bin/sh
command -v fd && exit 1

version=${1:-v10.2.0}
dir="fd-$version-x86_64-unknown-linux-musl"
url="https://github.com/sharkdp/fd/releases/download/
    $version/$dir.tar.gz"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

tar xf hic && rm hic
install $dir/fd -Dt $HOME/.local/bin
install $dir/fd.1 -m 644 -Dt $HOME/.local/share/man/man1
install $dir/autocomplete/fd.bash -m 644 -Dt $HOME/.local/share/bash-completion/completions
rm -r $dir

