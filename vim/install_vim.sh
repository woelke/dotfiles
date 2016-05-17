#!/bin/bash

if [ "$1" = "all" ]; then
    ./install_vim.sh install_vim
    ./install_vim.sh vim-plug 
    ./install_vim.sh undotree 
    ./install_vim.sh link_dotfile_init
    vim -c "call InstallMe()"
    ./install_vim.sh link_dotfile
    ./install_vim.sh ycm
fi

if [ "$1" = "install_lua" ]; then  
    #source http://www.lua.org/download.html
    curl -R -O http://www.lua.org/ftp/lua-5.2.3.tar.gz 
    tar zxf lua-5.2.3.tar.gz
    cd lua-5.2.3
    make linux 
    sudo make install
fi

##-- install vim --##
#https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
if [ "$1" = "install_vim" ]; then  
    #https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

    #requirements
    sudo apt-get -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
        ruby-dev
   
    ./install_vim.sh install_lua 

    #delete old stuff
    sudo apt-get -y remove vim vim-runtime gvim
    sudo apt-get -y remove vim-tiny vim-common vim-gui-common

    #download, configure and install vim
    cd ~
    git clone https://github.com/vim/vim/ vim_build
    cd vim_build
    export LUA_PREFIX=/usr/local
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp \
                --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/config \
                --enable-perlinterp \
                --enable-luainterp \
                --enable-gui=gtk2 --enable-cscope --prefix=/usr
    make VIMRUNTIMEDIR=/usr/share/vim/vim74
    sudo make install

    #set fim as default editor
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    sudo update-alternatives --set editor /usr/bin/vim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
    sudo update-alternatives --set vi /usr/bin/vim

    #remove build directory  
    cd ~
    rm -rf vim_build
fi
##--install vim-plug --##
#plugin manager for vim
#https://github.com/junegunn/vim-plug
if [ "$1" = "vim-plug" ]; then  
    mkdir -p ~/.vim/autoload
    curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

##-- configure persistent undo tree --##
#selbst definierter speicherort für alle undo dateien
if [ "$1" = "undotree" ]; then  
    mkdir -p ~/.vim/undo
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
    #whereami=$(pwd)
    #cd ~/.vim/bundle/YouCompleteMe
    #./install.sh --clang-completer 

    #if [ "$2" = "problem" ]; then  
        #cd $whereami 
        #./buildclang-sh all
        #sudo ./buildclang-sh install

        #cd ~/.vim/bundle/YouCompleteMe
        #./install.sh --clang-completer --system-libclang
    #fi
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

