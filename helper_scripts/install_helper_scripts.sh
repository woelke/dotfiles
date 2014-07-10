#!/bin/bash

if [ "$1" = "all" ]; then
    ./install_helper_scripts.sh auto_cat 
fi

if [ "$1" = "auto_cat" ]; then
    current_dir=$(pwd)
    cd /usr/local/sbin/.
    sudo ln -s $current_dir/auto_cat auto_cat 
fi
