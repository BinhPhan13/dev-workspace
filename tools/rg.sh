#!/bin/sh
command -v rg && exit 1

version=${1:-14.1.1}
dir="ripgrep-$version-x86_64-unknown-linux-musl"
url="https://github.com/BurntSushi/ripgrep/releases/download/
    $version/$dir.tar.gz"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

tar xf hic && rm hic
install $dir/rg -Dt $HOME/.local/bin
install $dir/doc/rg.1 -m 644 -Dt $HOME/.local/share/man/man1
install $dir/complete/rg.bash -m 644 -Dt $HOME/.local/share/bash-completion/completions
rm -r $dir

