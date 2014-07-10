#!/bin/bash

function ask_for {
    while true; do 
        echo $1
        read -n 1 input
        if [ $input = "Y" ] || [ $input = "y" ]; then
            return 1
        elif [ $input = "N" ] || [ $input = "n" ]; then
            return 0 
        fi
    done
}


if [ $# = 0 ]; then
    ./bootstrap.sh programmes
    ./bootstrap.sh zsh 
    ./bootstrap.sh helper 
    ./bootstrap.sh vim 
    ./bootstrap.sh sec 
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

    python3 linux_easy_install.py --check all
    if [ $? != 0 ]; then
        ask_for "Not all programmes can be installed. Shall I ignore these files? (Y/n)"
        if [ $? = 0 ]; then
            exit 0
        fi
    fi

    python3 linux_easy_install.py --install all
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

    ./install_vim all
fi

##############
# handle sec #
##############

if [ $1 = "dsec" ]; then
    cd sec

    echo "--------------"
    echo "- handle sec -"
    echo "--------------"

    gpg sec.tgz.gpg
    tar --auto-compress --extract --file sec.tgz 
    rm sec.tgz
fi

if [ $1 = "sec" ]; then
    ./bootstrap.sh dsec

    cd sec
    ./sec.sh all
fi

if [ $1 = "esec" ]; then
    cd sec

    echo "--------------"
    echo "- handle sec -"
    echo "--------------"

    tar --gzip --create --file sec.tgz config sec.sh
    #gpg -c sec.tgz
    gpg --cipher-algo AES256 --symmetric sec.tgz
    rm sec.tgz

fi


