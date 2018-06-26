Ubuntu Specific Configuration
=============================

Ubuntu 18.04
============
GNOME 3 - Disable animations
    
    gsettings set org.gnome.desktop.interface enable-animations false
    
Swap Capslock and Escape

    sudo apt install -y gnome-tweak-tool
    gnome-tweak
    #!Do manual: Keyboard & Mouse -> Additional Layout Options -> Caps Lock key behavior -> Swap ESC and Caps Lock

Thinkpad x1c6 fixes
-------------------

    see [link](https://mensfeld.pl/2018/05/lenovo-thinkpad-x1-carbon-6th-gen-2018-ubuntu-18-04-tweaks/)

Deactivate Touchpad when typing ([source](https://wiki.ubuntuusers.de/Touchpad/)):

    printf "#Deactivate Touchpad when typing\nsyndaemon -i 2 -d -t\n\n" >> ~/.local/bin/autostart_script
