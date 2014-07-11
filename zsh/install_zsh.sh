#!/bin/bash

if [ "$1" = "all" ]; then
    ./install_zsh.sh install
    ./install_zsh.sh link_dotfile
fi

if [ "$1" = "install" ]; then
    sudo apt-get -y install zsh
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh 
    chsh -s /bin/zsh #change login shell 
fi

if [ "$1" = "link_dotfile" ]; then
    current_dir=$(pwd)
    cd ~/.
    ln -sf $current_dir/.zshrc .zshrc 
fi

