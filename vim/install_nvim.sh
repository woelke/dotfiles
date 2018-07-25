#!/bin/bash

# Abort this script on any error
set -e

echo "####################################"
echo "## $0 $@"
echo "####################################"

nvim_path="${HOME}/.config/nvim"

if [ "$1" = "all" ]; then
  $0 preperation
  $0 install_neovim
  $0 vim_plug
  $0 undotree
  $0 link_nvim_config
  $0 set_install_rc
  nvim -c "call InstallMe()"
  $0 set_init_rc
  $0 install_gui
  $0 swap_directory
  $0 neovim_remote
  $0 load_spellfiles
  $0 sec_vim
fi

if [ "$1" = "preperation" ]; then
  mkdir tmp
  sudo apt install -y libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
  sudo apt install -y python-dev python-pip python3-dev python3-pip
  sudo apt install -y xclip
  sudo pip2 install --upgrade pip
  sudo pip3 install --upgrade pip
fi

if [ "$1" = "install_neovim" ]; then
  git clone https://github.com/neovim/neovim tmp/neovim
  cd tmp/neovim
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  # Add python suport #
  sudo pip2 install --upgrade neovim
  sudo pip3 install --upgrade neovim
fi

if [ "$1" = "vim_plug" ]; then
  curl -fLo $nvim_path/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ "$1" = "undotree" ]; then
  mkdir -p $nvim_path/undo
fi

if [ "$1" = "link_nvim_config" ]; then
  echo "\" Enter here your specific nvim configurations" > ~/.custom_nvimrc
  current_dir=$(pwd)
  cd $nvim_path
  ln -sf $current_dir/nvim_config
fi

if [ "$1" = "set_install_rc" ]; then
  echo "source $nvim_path/nvim_config/install_rc.vim" > $nvim_path/init.vim
fi

if [ "$1" = "set_init_rc" ]; then
  echo "source $nvim_path/nvim_config/init.vim" > $nvim_path/init.vim
  echo "source $nvim_path/nvim_config/ginit.vim" > $nvim_path/ginit.vim
fi

if [ "$1" = "install_gui" ]; then
  # neovim-qt
  sudo apt install -y qt5-default
  git clone https://github.com/equalsraf/neovim-qt tmp/neovim-qt
  cd tmp/neovim-qt
  mkdir build
  cd build
  cmake -DCMAKE_BUILD_TYPE=Release ..
  make
  sudo make install
  # neovim-gtk
  sudo apt install -y cargo libgtk-3-dev
  git clone https://github.com/daa84/neovim-gtk tmp/neovim-gtk
  cd tmp/neovim-gtk
  sudo make install
  ## disables the HEADEBAR even when started from a non terminal env
  print "\n# neovim-gtk env variable\nexport NVIM_GTK_NO_HEADERBAR=1" >> ~/.profile
fi

if [ "$1" = "swap_directory" ]; then
  mkdir -p $nvim_path/swap
fi

if [ "$1" = "neovim_remote" ]; then
  pip3 install --user neovim-remote
fi

if [ "$1" = "load_spellfiles" ]; then
  tmp_file="tmp/tmp.txt"
  touch $tmp_file
  nvim $tmp_file
fi

if [ "$1" = "sec_vim" ]; then
  mkdir -p $nvim_path/sec_plugged
fi
