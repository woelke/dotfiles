Ubuntu Specific Configuration
=============================

Ubuntu 14.04
============
Auto hide of Launcher:

    #Launcher -> Appearance -> Behavior -> Auto-hide the Launcher -> ON

Disable the HUD (Head-Up-Display):

    #Launcher -> Keyboard -> Shortcuts -> Key to show the HUD -> Backspace Key
    
Enable Workspace (multiple Desktops):

    #Launcher -> Apperance -> Behavior -> Enable Workspace

Unity
    
    sudo apt-get update
    sudo apt-get install compizconfig-settings-manager
    ccsm 
    #Effects -> Animations -> Off
    #Effects -> Fading Windows -> Off 
    
    #Disable new windows opening in background    
    #http://askubuntu.com/questions/310470/newly-opened-applications-open-in-background
    #General -> General Options -> Focus & Raise Behaiviour -> Focus Prevention Level -> Off

Show files on Destkop

    sudo apt-get install gnome-tweak-tool
    #Launcher -> Tweak Tool -> Destkop -> Home


Apple-Keyboard
==============
Function keys as default and swap Option and Command key ([source](https://help.ubuntu.com/community/AppleKeyboard))

    echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
    echo options hid_apple swap_opt_cmd=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
    sudo update-initramfs -u -k all
    sudo reboot

    

