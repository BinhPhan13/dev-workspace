FROM debian:bookworm-slim
WORKDIR /app

ARG VERSION=3.4
ARG TMUX=tmux-$VERSION

RUN apt update && \
  apt install -y curl gcc make libevent-dev libncurses-dev bison && \
  rm -rf /var/lib/apt/ && \
  curl -LO https://github.com/tmux/tmux/releases/download/$VERSION/$TMUX.tar.gz && \
  tar xf $TMUX.tar.gz

RUN $TMUX/configure --enable-static && make && make install

