#!/bin/bash
if ! [ -d $HOME/.local/nvim-linux64 ]; then
  url="https://github.com/neovim/neovim/releases/download/
      v0.10.3/nvim-linux64.tar.gz"
  curl -L ${url//[[:space:]]/} -o hic || exit 1

  mkdir -p $HOME/.local/
  tar xf hic -C $HOME/.local/ && rm hic
fi

mkdir -p $HOME/.local/bin/
ln -sf $HOME/.local/nvim-linux64/bin/nvim $HOME/.local/bin/nv

rm -f $HOME/.local/bin/vi &&
echo '#!/bin/bash
nv --noplugin $@
' > $HOME/.local/bin/vi &&
chmod +x $HOME/.local/bin/vi

