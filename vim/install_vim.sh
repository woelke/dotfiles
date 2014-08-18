#!/bin/bash

if [ "$1" = "all" ]; then
    ./install_vim.sh install_vim
    ./install_vim.sh vundle
    ./install_vim.sh undotree 
    ./install_vim.sh link_dotfile_init
    vim -c "call InstallMe()"
    ./install_vim.sh link_dotfile
    ./install_vim.sh ycm
fi

##-- install vim --##
#https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
if [ "$1" = "install_vim" ]; then  
    #this looks like the officaly way
    #http://www.vim.org/mercurial.php
    #need overwork
    
  sudo apt-get -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial

  sudo apt-get -y remove vim vim-runtime gvim gnome-vim
  sudo apt-get -y remove vim-tiny vim-common vim-gui-common

  cd ~
  hg clone https://code.google.com/p/vim/
  cd vim
  ./configure --with-features=huge \
              --enable-rubyinterp \
              --enable-pythoninterp \
              --enable-perlinterp \
              --enable-gui=gnome2 \
              --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ \
              --enable-cscope --prefix=/usr
  make VIMRUNTIMEDIR=/usr/share/vim/vim74
  sudo make install

  sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
  sudo update-alternatives --set editor /usr/bin/vim
  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
  sudo update-alternatives --set vi /usr/bin/vim
fi


##-- install vundle --##
#plugin manager für vim
#https://github.com/gmarik/vundle#about
#http://gmarik.info/blog/2011/05/17/chicken-or-egg-dilemma
if [ "$1" = "vundle" ]; then  
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
#cmd in vim ausführen :BundleInstall
fi


##-- configure persistent undo tree --##
#selbst definierter speicherort für alle undo dateien
if [ "$1" = "undotree" ]; then  
    mkdir ~/.vim/undo
fi


if [ "$1" = "link_dotfile_init" ]; then
    current_dir=$(pwd)
    cd ~/.
    ln -sf $current_dir/.vimrc_init .vimrc 
    ln -sf $current_dir/.vim_bundles.vim .vim_bundles.vim
fi


if [ "$1" = "link_dotfile" ]; then
    current_dir=$(pwd)
    cd ~/.
    ln -sf $current_dir/.vimrc .vimrc 
    ln -sf $current_dir/.vim_bundles.vim .vim_bundles.vim
    ln -sf $current_dir/.gdbinit .gdbinit #gnu debugger init file
    ln -sf $current_dir/.pyclewn_keys.gdb .pyclewn_keys.gdb #pyclewn is a vim plugin für gdb
    ln -sf $current_dir/.clang-format .clang-format #
fi


##-- install YouCompleteMe --##
#autovervollständigung, code sprünge zu definitionen 
#http://valloric.github.io/YouCompleteMe/
#https://github.com/Valloric/YouCompleteMe/blob/master/cpp/ycm/.ycm_extra_conf.py
if [ "$1" = "ycm" ]; then  
    sudo apt-get install python-dev
    whereami=$(pwd)
    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer 

    #if [ "$2" = "problem" ]; then  
        #cd $whereami 
        #./buildclang-sh all
        #sudo ./buildclang-sh install

        #cd ~/.vim/bundle/YouCompleteMe
        #./install.sh --clang-completer --system-libclang
    #fi
fi

##-- install astyle --##
#source code formatter
#http://astyle.sourceforge.net/
#für später sudo apt-get install astyle
if [ "$1" = "astyle" ]; then  
    cd ~/Downloads
#downlaod  http://sourceforge.net/projects/astyle/"
    tar xfvz astyle_2.03_linux.tar.gz
    cd astyle/build/gcc
    make
    sudo make install
fi

##-- install plyclewn --##
#c++ und pyhton debugger
#http://pyclewn.sourceforge.net/
#sudo apt-get install vim-gnome
#sudo apt-get install gdb
if [ "$1" = "pyclewn" ]; then  
    cd ~/Downloads
    sudo apt-get install gdb
    sudo apt-get install vim-gnome
#download hier: http://sourceforge.net/projects/pyclewn/
    tar xvfz pyclewn-1.11.py2.tar.gz
    cd pyclewn-1.11.py2
    sudo python setup.py install --force
fi


##-- To Test --##
#https://github.com/Valloric/ListToggle

