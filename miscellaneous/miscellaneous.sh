#!/bin/bash

if [ "$1" = "all" ]; then
    ./miscellaneous.sh xresources 
    ./miscellaneous.sh nautilus_gvim 
    ./miscellaneous.sh nautilus_scripts 
    ./miscellaneous.sh terminator_config 
    ./miscellaneous.sh auto_cat
    ./miscellaneous.sh firefox_tunnel_to
    ./miscellaneous.sh alarm 
    ./miscellaneous.sh autoenv
fi

if [ "$1" = "xresources" ]; then
    current_dir=$(pwd)
    cd ~/.
    ln -s $current_dir/.Xresources .Xresources
    xrdb -merge ~/.Xresources #load settings
fi

#add integration for nautilus file browser
if [ "$1" = "nautilus_gvim" ]; then  
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


if [ "$1" = "nautilus_scripts" ]; then  
    current_dir=$(pwd)
    cd ~/.local/share/nautilus/scripts
    ln -s $current_dir/scripts/nautilus/merge_pdf
    ln -s $current_dir/scripts/nautilus/terminator
fi


if [ "$1" = "auto_cat" ]; then
    current_dir=$(pwd)
    cd /usr/local/sbin/.
    sudo ln -s $current_dir/scripts/auto_cat
fi

if [ "$1" = "firefox_tunnel_to" ]; then
    current_dir=$(pwd)
    cd /usr/local/sbin/.
    sudo ln -s $current_dir/scripts/firefox_tunnel_to
fi

if [ "$1" = "alarm" ]; then
    sudo apt-get -y install sharutils
    sudo apt-get -y install redshift 

    current_dir=$(pwd)
    cd /usr/local/sbin/.
    sudo ln -s $current_dir/scripts/alarm
fi

if [ "$1" = "terminator_config" ]; then  
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

if [ "$1" = "autoenv" ]; then
    #on entering a folder with a .env file it is automatically executed
    git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
fi
