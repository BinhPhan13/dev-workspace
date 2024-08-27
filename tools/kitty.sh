#!/bin/bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    installer=version-0.35.2 launch=n &&

mkdir -p $HOME/.config/
rm -rf $HOME/.config/kitty/

path=$(realpath $0)
cp -r ${path%/*}/../.config/kitty/ $HOME/.config/

