#!/bin/bash
which rclone && exit 1
if ! which unzip; then echo "no unzip!"; exit 1; fi

url="https://github.com/rclone/rclone/releases/download/
    v1.68.2/rclone-v1.68.2-linux-amd64.zip"
curl -L ${url//[[:space:]]/} -o hic || exit 1

unzip hic
rm hic
dir="rclone-v1.68.2-linux-amd64"

mkdir -p $HOME/.local/bin/
cp $dir/rclone $HOME/.local/bin/

mkdir -p $HOME/.local/share/man/man1/
cp $dir/rclone.1 $HOME/.local/share/man/man1/

mkdir -p $HOME/.local/share/bash-completion/completions/
$dir/rclone completion bash $HOME/.local/share/bash-completion/completions/rclone.bash

rm -rf $dir

