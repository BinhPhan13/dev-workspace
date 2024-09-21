#!/bin/bash
[[ -d $HOME/.local/kitty.app/ ]] && exit 1

curl -L https://sw.kovidgoyal.net/kitty/installer.sh |
  sh /dev/stdin installer=version-0.35.2 launch=n || exit 1

mkdir -p $HOME/.local/bin/
rm -f $HOME/.local/bin/{kitty,kitten}
ln -s $HOME/.local/{kitty.app,}/bin/kitty
ln -s $HOME/.local/{kitty.app,}/bin/kitten

mkdir -p $HOME/.config/
rm -rf $HOME/.config/kitty/

dir=$(dirname $0)
cp -r $dir/../.config/kitty/ $HOME/.config/

