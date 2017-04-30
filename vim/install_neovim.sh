#!/bin/bash

if [ "$1" = "all" ]; then
  ./install_vim.sh preperation
  ./install_vim.sh install_neovim
  ./install_vim.sh vim_plug 
  ./install_vim.sh undotree 
fi

if [ "$1" = "preperation" ]; then  
  sudo apt install -y libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
  sudo apt install -y python-dev python-pip python3-dev python3-pip
  sudo pip2 install --upgrade pip
  sudo pip3 install --upgrade pip
fi

if [ "$1" = "install_neovim" ]; then  
  git clone https://github.com/neovim/neovim
  cd neovim
  make
  sudo make install
  # Add python suport #
  sudo pip2 install --upgrade neovim
  sudo pip3 install --upgrade neovim
fi

if [ "$1" = "vim_plug" ]; then  
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ "$1" = "undotree" ]; then  
  mkdir -p ~/.config/nvim/undo
if
