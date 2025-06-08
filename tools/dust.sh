#!/bin/sh
command -v dust && exit 1

version=${1:-v1.2.0}
dir="dust-$version-x86_64-unknown-linux-musl"
url="https://github.com/bootandy/dust/releases/download/
    $version/$dir.tar.gz"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

tar xf hic && rm hic
install $dir/dust -D $HOME/.local/bin
rm -r $dir

