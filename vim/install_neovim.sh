#!/bin/bash

if [ "$1" = "all" ]; then
  ./install_vim.sh preperation
  ./install_vim.sh install_neovim
fi

#source: https://github.com/neovim/neovim/wiki/Installing-Neovim
if [ "$1" = "preperation" ]; then  
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt update
  sudo apt install software-properties-common
  sudo apt install python-dev python-pip python3-dev python3-pip
  sudo pip2 install --upgrade pip
  sudo pip3 install --upgrade pip
fi

#source: https://github.com/neovim/neovim/wiki/Installing-Neovim
if [ "$1" = "install_neovim" ]; then  
  sudo apt install neovim
  # Add python suport #
  sudo pip2 install --upgrade neovim
  sudo pip3 install --upgrade neovim
fi
