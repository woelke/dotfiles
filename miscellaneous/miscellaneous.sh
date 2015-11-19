#!/bin/bash

if [ "$1" = "all" ]; then
    ./miscellaneous.sh xresources 
    ./miscellaneous.sh nautilus 
    ./miscellaneous.sh terminator 
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

if [ "$1" = "terminator" ]; then  
    mkdir ~/.config/terminator
    cd ~/.config/terminator

cat > config <<EOF 
[global_config]
[keybindings]
[profiles]
  [[default]]
    scrollback_lines = 20000
    font = Monospace 12
    use_system_font = False
    background_image = None
[layouts]
  [[default]]
    [[[child1]]]
      type = Terminal
      parent = window0
    [[[window0]]]
      type = Window
      parent = ""
[plugins]
EOF

fi
