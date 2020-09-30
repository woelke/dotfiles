#!/bin/bash

# Abort this script on any error
set -e

echo "####################################"
echo "## $0 $@"
echo "####################################"

nvim_path="${HOME}/.config/nvim"
llvm="$HOME/llvm"

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
  $0 llvm
  $0 coc_ccls
fi

if [ "$1" = "preperation" ]; then
  mkdir tmp
  sudo apt install -y libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
  sudo apt install -y python-dev python3-dev python3-pip
  sudo apt install -y xclip
  sudo pip3 install --upgrade pip
fi

if [ "$1" = "install_neovim" ]; then
  sudo apt install nvim
  # Add python suport #
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
  ln -sf $current_dir/nvim_config/coc-settings.json
fi

if [ "$1" = "set_install_rc" ]; then
  echo "source $nvim_path/nvim_config/install_rc.vim" > $nvim_path/init.vim
fi

if [ "$1" = "set_init_rc" ]; then
  echo "source $nvim_path/nvim_config/init.vim" > $nvim_path/init.vim
  echo "source $nvim_path/nvim_config/ginit.vim" > $nvim_path/ginit.vim
fi

if [ "$1" = "install_gui" ]; then
  # neovim-gtk
  sudo apt install libatk1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev libglib2.0-dev libgtk-3-dev libpango1.0-dev
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

#if [ "$1" = "coc_ccls" ]; then
  #sudo apt install zlib1g-dev libncurses-dev libncurses5 clang libclang-dev rapidjson-dev ninja-build

  #git clone https://github.com/llvm/llvm-project.git tmp/llvm-project
  #pushd tmp/llvm-project
    #pushd llvm
      #cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS=clang
      #ninja -C Release clangFormat clangFrontendTool clangIndex clangTooling clang
      #sudo ninja -C Release install
    #popd
  #popd

  #git clone --depth=1 --recursive https://github.com/MaskRay/ccls tmp/ccls
  #pushd tmp/ccls
    #cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
        #-DCMAKE_PREFIX_PATH=/usr/lib/llvm-10 \
        #-DLLVM_INCLUDE_DIR=/usr/lib/llvm-10/include \
        #-DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-10/
    #cmake --build Release
    #sudo cmake --build Release --target install
  #popd
#fi

if [ "$1" = "llvm" ]; then
  pushd tmp
  wget --output-document="llvm-10.0.1.tar.xz" https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz

  if [ -d ${llvm} ]; then rm -rf ${llvm}; fi
  mkdir ${llvm}

  tar -xf llvm-10.0.1.tar.xz --directory=${llvm}  --strip 1
  popd
fi

if [ "$1" = "coc_clangd" ]; then
  # https://github.com/clangd/coc-clangd
  sudo apt install nodejs
fi
