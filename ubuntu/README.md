Ubuntu Specific Configuration
=============================

Ubuntu 16.04
============
Auto hide of Launcher:

    #Launcher -> Appearance -> Behavior -> Auto-hide the Launcher -> ON

Disable the HUD (Head-Up-Display):

    #Launcher -> Keyboard -> Shortcuts -> Key to show the HUD -> Backspace Key
    
Disable sticky edges:

    #Launcher -> Displays -> Sticky edges -> OFF

Unity
    
    sudo apt update
    sudo apt install compizconfig-settings-manager
    ccsm 
    #!Do manual: Effects -> Animations -> Off
    #!Do manual: Effects -> Fading Windows -> Off 
    
Disable new windows opening in background [source](http://askubuntu.com/questions/310470/newly-opened-applications-open-in-background)
    
    ccsm
    #!Do manual: General -> General Options -> Focus & Raise Behaiviour -> Focus Prevention Level -> Off

Swap Capslock and Escape

    sudo apt install gnome-tweak-tool
    gnome-tweak-tool
    #!Do manual: Typing -> Caps Lock key behavior -> Swap ESC and Caps Lock
    

Show files on Destkop

    sudo apt-get install gnome-tweak-tool
    #Launcher -> Tweak Tool -> Destkop -> Home

Add spell files to vim by downlaoding all _de_ and _en_ files from [here](http://ftp.vim.org/vim/runtime/spell/) to ~/.vim/spell/

    

