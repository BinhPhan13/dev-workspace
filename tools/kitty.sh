#!/bin/bash
if [[ -d $HOME/.local/kitty.app/ ]]; then echo "existed !"; exit 1; fi

curl -L https://sw.kovidgoyal.net/kitty/installer.sh |
  sh /dev/stdin installer=version-0.35.2 launch=n || exit 1

mkdir -p $HOME/.local/bin/
ln -sf $HOME/.local/{kitty.app,}/bin/kitty
ln -sf $HOME/.local/{kitty.app,}/bin/kitten

