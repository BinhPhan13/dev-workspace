#!/bin/sh
command -v lazygit && exit 1

version=${1:-0.51.1}
url="https://github.com/jesseduffield/lazygit/releases/download/
    v$version/lazygit_$version _Linux_x86_64.tar.gz"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

mkdir lazygit && tar xf hic -C lazygit && rm hic
install lazygit/lazygit -Dt $HOME/.local/bin
rm -r lazygit

