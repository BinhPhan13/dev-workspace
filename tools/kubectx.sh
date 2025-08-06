#!/bin/sh
command -v kubectx && exit 1

version=v${1:-0.9.5}

file="$HOME/.local/share/bash-completion/completions/kubectx"
url="https://raw.githubusercontent.com/ahmetb/kubectx/refs/tags/
    $version/completion/kubectx.bash"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o $file

dir="kubectx_${version}_linux_x86_64"
url="https://github.com/ahmetb/kubectx/releases/download/
    $version/$dir.tar.gz"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

mkdir $dir && tar xf hic -C $dir && rm hic
install $dir/kubectx -Dt $HOME/.local/bin
rm -rf $dir

