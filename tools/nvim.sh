#!/bin/sh
if ! [ -d $HOME/.local/nvim ]; then
  url="https://github.com/BinhPhan13/dev-workspace/releases/download/assets/nvim.tar.gz"
  curl -fL $url -o hic || exit 1
  mkdir -p $HOME/.local/bin
  tar xf hic -C $HOME/.local && rm hic
fi

ln -sf $HOME/.local/nvim/bin/nvim $HOME/.local/bin/nv
echo '#!/bin/bash
nv --noplugin $@
' > $HOME/.local/bin/vi &&
chmod +x $HOME/.local/bin/vi

