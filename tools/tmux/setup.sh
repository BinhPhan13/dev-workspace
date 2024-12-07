#!/bin/bash
dir=$(dirname $0)

mkdir -p $HOME/.local/bin/
cp $dir/tmux $HOME/.local/bin/

mkdir -p $HOME/.local/share/man/man1/
cp $dir/tmux.1 $HOME/.local/share/man/man1/

url="https://raw.githubusercontent.com/imomaliev/
    tmux-bash-completion/master/completions/tmux"
curl -L ${url//[[:space:]]/} -o tmux.bash || exit 1

mkdir -p $HOME/.local/share/bash-completion/completions/
mv tmux.bash $HOME/.local/share/bash-completion/completions/

rm -rf $HOME/.local/tmux-plugins/
git clone https://github.com/tmux-plugins/tpm $HOME/.local/tmux-plugins/

