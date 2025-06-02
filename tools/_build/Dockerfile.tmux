from debian:bullseye-slim
run apt update && apt install -y curl gcc make libevent-dev libncurses-dev bison

workdir /app
arg version=3.5a
run curl -L https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz -o hic && tar xf hic
run cd tmux-$version && ./configure --enable-static --prefix=/app && make && make install

