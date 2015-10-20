#!/bin/bash

if [ "$1" = "all" ]; then
    ./miscellaneous.sh xresources 
    ./miscellaneous.sh nautilus 
fi

if [ "$1" = "xresources" ]; then
    current_dir=$(pwd)
    cd ~/.
    ln -s $current_dir/.Xresources .Xresources
    xrdb -merge ~/.Xresources #load settings
fi

#add integration for nautilus file browser
if [ "$1" = "nautilus" ]; then  
    cd ~/.local/share/applications/

cat > vim.desktop <<EOF 
[Desktop Entry]
Categories=;
Comment=Edit file in Vim
Exec=gvim %f
GenericName=Process Viewer
Hidden=false
Icon=gvim
Name=gvim
Terminal=true
Type=Application
Version=1.0
EOF

fi
