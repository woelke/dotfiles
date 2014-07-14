#!/bin/bash

if [ $# = 0 ]; then
    ./bootstrap.sh programmes
    ./bootstrap.sh zsh 
    ./bootstrap.sh helper 
    ./bootstrap.sh vim 
    ./bootstrap.sh sec 
    ./bootstrap.sh ubuntu 
    exit 0
fi

########################################
# install all important linux progamms #
########################################

if [ $1 = "programmes" ]; then
    cd linux_programmes

    echo "----------------------------"
    echo "- install linux programmes -"
    echo "----------------------------"
    
    ./linux_programmes.sh all
fi

###############
# install zsh #
###############

if [ $1 = "zsh" ]; then
    cd zsh

    echo "---------------"
    echo "- install zsh -"
    echo "---------------"

    ./install_zsh.sh all
fi

##########################
# install helper scripts #
##########################

if [ $1 = "helper" ]; then
    cd helper_scripts 

    echo "--------------------------"
    echo "- install helper scripts -"
    echo "--------------------------"

    ./install_helper_scripts.sh all
fi

###############
# install vim #
###############

if [ $1 = "vim" ]; then
    cd vim

    echo "---------------"
    echo "- install vim -"
    echo "---------------"

    ./install_vim.sh all
fi

##############
# handle sec #
##############

if [ $1 = "dsec" ]; then
    cd sec

    gpg sec.tar.gz.gpg
    tar --auto-compress --extract --file sec.tar.gz 
    rm sec.tar.gz
fi

if [ $1 = "sec" ]; then
    ./bootstrap.sh dsec
    cd sec
    
    echo "--------------"
    echo "- handle sec -"
    echo "--------------"
    
    ./sec.sh all
fi

if [ $1 = "esec" ]; then
    cd sec

    tar --gzip --create --file sec.tar.gz sec.sh .ssh 
    gpg --cipher-algo AES256 --symmetric sec.tar.gz
    rm sec.tar.gz
fi


#################################
# ubuntu specific configuration #
#################################

if [ $1 = "ubuntu" ]; then
    cd ubuntu

    echo "---------------------------------"
    echo "- ubuntu specific configuration -"
    echo "---------------------------------"

    ./ubuntu.sh all
fi
