#!/bin/bash

echo "Install haskell Platform"
sudo apt install haskell-platform -y
sudo apt-get install freeglut3-dev

echo "Install Stack"
curl -sSL https://get.haskellstack.org/ | sh
stack update
stack upgrade

echo "Update Cabal"
cabal update
cabal install Cabal cabal-install
export PATH=~/.cabal/bin:$PATH



