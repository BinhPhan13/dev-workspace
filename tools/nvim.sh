#!/bin/bash
install_dir='nvim-linux-x86_64'
if ! [ -d $HOME/.local/$install_dir ]; then
  url="https://github.com/neovim/neovim/releases/download/
      v0.11.1/$install_dir.tar.gz"
  curl -L ${url//[[:space:]]/} -o hic || exit 1

  mkdir -p $HOME/.local/
  tar xf hic -C $HOME/.local/ && rm hic
fi

mkdir -p $HOME/.local/bin/
ln -sf $HOME/.local/$install_dir/bin/nvim $HOME/.local/bin/nv

rm -f $HOME/.local/bin/vi &&
echo '#!/bin/bash
nv --noplugin $@
' > $HOME/.local/bin/vi &&
chmod +x $HOME/.local/bin/vi

