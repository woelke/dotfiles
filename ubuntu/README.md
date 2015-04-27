Ubuntu Specific Configuration
=============================

Ubuntu 14.04
============
Auto hide of Launcher:

    Launcher -> Appearance -> Behavior -> Auto-hide the Launcher -> ON

Disable the HUD (Head-Up-Display):

    Launcher -> Keyboard -> Shortcuts -> Key to show the HUD -> Backspace Key

Uninstall gnome-keyring:

    sudo apt-get remove gnome-keyring
    sudo reboot 

Apple-Keyboard
==============
Function keys as default

    echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
    echo 1 | sudo tee /sys/module/hid_apple/parameters/swap_opt_cmd
    echo "module/hid_apple/parameters/fnmode = 2" | sudo tee -a /etc/sysfs.conf
    echo "module/hid_apple/parameters/swap_opt_cmd = 1" | sudo tee -a /etc/sysfs.conf

    

