#!/bin/bash

echo "####################################"
echo "## $0 $@"
echo "####################################"

if [ "$1" = "all" ]; then
  $0 install
  $0 link_dotfile
fi

if [ "$1" = "install" ]; then
  sudo apt-get -y install zsh
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh 
  sudo chsh -s $(which zsh) $(whoami) #change login shell 
fi

if [ "$1" = "link_dotfile" ]; then
  current_dir=$(pwd)
  cd ~/.
  ln -sf $current_dir/.zshrc .zshrc 
fi

