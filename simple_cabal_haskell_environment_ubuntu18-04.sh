#!/bin/bash

echo "Install haskell Platform"
sudo apt install haskell-platform -y

echo "Install Stack"
curl -sSL https://get.haskellstack.org/ | sh
stack update
stack upgrade

echo "Update Cabal"
cabal update
cabal install Cabal cabal-install
export PATH=~/.cabal/bin:$PATH



