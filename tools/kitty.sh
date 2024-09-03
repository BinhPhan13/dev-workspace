#!/bin/bash
[[ -d $HOME/.local/kitty.app/ ]] && exit 1

curl -L https://sw.kovidgoyal.net/kitty/installer.sh |
  sh /dev/stdin installer=version-0.35.2 launch=n || exit 1

mkdir -p $HOME/.config/
rm -rf $HOME/.config/kitty/

dir=$(dirname $0)
cp -r $dir/../.config/kitty/ $HOME/.config/

