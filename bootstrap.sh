#!/bin/bash

if [ $# = 0 ]; then
    ./bootstrap.sh programs
    ./bootstrap.sh zsh 
    ./bootstrap.sh miscellaneous 
    ./bootstrap.sh nvim 
    ./bootstrap.sh sec 
    exit 0
fi


########################################
# install all important linux progamms #
########################################

if [ $1 = "programs" ]; then
    cd linux_programs

    echo "--------------------------"
    echo "- install linux programs -"
    echo "--------------------------"
    
    ./linux_programs.sh all
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


################
# install nvim #
################

if [ $1 = "nvim" ]; then
    cd vim

    echo "---------------"
    echo "- install nvim -"
    echo "---------------"

    ./install_nvim.sh all
fi


#################
# miscellaneous #
#################

if [ $1 = "miscellaneous" ]; then
    cd miscellaneous

    echo "-----------------"
    echo "- miscellaneous -"
    echo "-----------------"

    ./miscellaneous.sh all
fi


##############
# handle sec #
##############

if [ $1 = "dsec" ]; then
    cd sec
   
    while true; do
        gpg sec.tar.gz.gpg

        if [ $? = "0" ]; then
            tar --auto-compress --extract --file sec.tar.gz 
            rm sec.tar.gz
            exit 0 
        fi
    done
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

    tar --gzip --create --file sec.tar.gz sec.sh folder 
    gpg --cipher-algo AES256 --symmetric sec.tar.gz
    rm sec.tar.gz
fi

