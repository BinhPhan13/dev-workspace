#!/bin/bash
path=$(realpath $0)
dir=${path%/*}

mkdir -p $HOME/.local/bin
cp $dir/tmux $HOME/.local/bin/

mkdir -p $HOME/.local/share/man/man1/
cp $dir/tmux.1 $HOME/.local/share/man/man1/

url="https://raw.githubusercontent.com/imomaliev/
    tmux-bash-completion/master/completions/tmux"
curl -L ${url//[[:space:]]/} -o tmux.bash &&
mkdir -p $HOME/.local/share/bash-completion/completions/
mv tmux.bash $HOME/.local/share/bash-completion/completions/

mkdir -p $HOME/.config/
rm -rf $HOME/.config/tmux/
cp -r $dir/../../.config/tmux/ $HOME/.config/

