#!/bin/bash
path=$(realpath $0)
dir=${path%/*}

docker build -t tmux:3.4 $dir &&
docker run -itd --name ioub --rm tmux:3.4 &&

docker cp ioub:/usr/local/bin/tmux .
docker cp ioub:/usr/local/share/man/man1/tmux.1 .

docker kill ioub

