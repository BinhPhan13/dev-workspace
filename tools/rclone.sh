#!/bin/sh
command -v rclone && exit 1
command -v unzip || { echo 'no unzip!' && exit 1; }

version=${1:-v1.69.3}
dir="rclone-$version-linux-amd64"
url="https://github.com/rclone/rclone/releases/download/
    $version/$dir.zip"
url=$(echo $url | tr -d '[[:space:]]')
curl -fL $url -o hic || exit 1

unzip hic && rm hic
install $dir/rclone -Dt $HOME/.local/bin
install $dir/rclone.1 -m 644 -Dt $HOME/.local/share/man/man1
rclone completion bash $dir/rclone.bash &&
install $dir/rclone.bash -m 644 -Dt $HOME/.local/share/bash-completion/completions
rm -r $dir

