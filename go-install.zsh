#!/bin/zsh

sudo rm -rf /usr/local/go && wget https://go.dev/dl/go1.22.1.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz

echo 'export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin' >> ~/.zsh

source ~/.zsh

go version
