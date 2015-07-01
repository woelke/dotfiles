Ubuntu Specific Configuration
=============================

Ubuntu 14.04
============
Auto hide of Launcher:

    Launcher -> Appearance -> Behavior -> Auto-hide the Launcher -> ON

Disable the HUD (Head-Up-Display):

    Launcher -> Keyboard -> Shortcuts -> Key to show the HUD -> Backspace Key

Unity

    sudo apt-get update
    sudo apt-get install compizconfig-settings-manager
    ccsm 
    #General -> General Options -> Focus & Raise Behaiviour -> Focus Prevention Level -> Off
    #Effects -> Animations -> Off
    #Effects -> Fading Windows -> Off 
    

Uninstall gnome-keyring:

    sudo apt-get remove gnome-keyring
    sudo reboot 

Apple-Keyboard
==============
Function keys as default and swap Option and Command key ([source](https://help.ubuntu.com/community/AppleKeyboard))

    echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
    echo options hid_apple swap_opt_cmd=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
    sudo update-initramfs -u -k all
    sudo reboot

    

