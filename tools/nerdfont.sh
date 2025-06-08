#!/bin/sh
version=${1:-v3.4.0}
fontname=${2:-DroidSansMono}
url="https://github.com/ryanoasis/nerd-fonts/releases/download/
    $version/$fontname.tar.xz"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

mkdir font && tar xf hic -C font && rm hic
install font/*Font-Regular.otf -m 644 -Dt $HOME/.fonts
rm -rf font

