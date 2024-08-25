#!/bin/bash
url="https://download.docker.com/linux/debian/dists/bookworm/pool/stable/amd64/
    containerd.io_1.7.20-1_amd64.deb"
curl -L ${url//[[:space:]]/} -o hic1.deb &&

url="https://download.docker.com/linux/debian/dists/bookworm/pool/stable/amd64/
    docker-ce-cli_27.1.2-1~debian.12~bookworm_amd64.deb"
curl -L ${url//[[:space:]]/} -o hic2.deb &&

url="https://download.docker.com/linux/debian/dists/bookworm/pool/stable/amd64/
    docker-ce_27.1.2-1~debian.12~bookworm_amd64.deb"
curl -L ${url//[[:space:]]/} -o hic3.deb &&

url="https://download.docker.com/linux/debian/dists/bookworm/pool/stable/amd64/
    docker-compose-plugin_2.29.1-1~debian.12~bookworm_amd64.deb"
curl -L ${url//[[:space:]]/} -o hic4.deb &&

url="https://download.docker.com/linux/debian/dists/bookworm/pool/stable/amd64/
    docker-buildx-plugin_0.16.2-1~debian.12~bookworm_amd64.deb"
curl -L ${url//[[:space:]]/} -o hic5.deb &&

sudo apt install -y ./hic{1..5}.deb && rm hic{1..5}.deb

