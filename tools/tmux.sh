#!/bin/sh
if ! command -v tmux; then
  url="https://github.com/BinhPhan13/dev-workspace/releases/download/assets/tmux.tar.gz"
  curl -fL $url -o hic || exit 1
  tar xf hic && rm hic

  dir="tmux"
  install $dir/tmux -Dt $HOME/.local/bin
  install $dir/tmux.1 -m 644 -Dt $HOME/.local/share/man/man1
  rm -r $dir
fi

if ! [ -d $HOME/.local/tpm ]; then
  version="3.1.0"
  url="https://github.com/tmux-plugins/tpm/archive/refs/tags/v$version.tar.gz"
  curl -fL $url -o hic || exit 1
  tar xf hic && rm hic
  mv tpm-$version $HOME/.local/tpm
fi

