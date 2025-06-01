#!/bin/bash
version=${1:-0.41.1}
dir='kitty.app'
if ! [ -d $HOME/.local/$dir ]; then
  curl -fL https://sw.kovidgoyal.net/kitty/installer.sh |
    sh /dev/stdin installer=version-$version launch=n || exit 1
fi

mkdir -p $HOME/.local/bin
ln -sf $HOME/.local/{$dir,}/bin/kitty
ln -sf $HOME/.local/{$dir,}/bin/kitten

