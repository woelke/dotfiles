#!/bin/bash

echo "####################################"
echo "## $0 $@"
echo "####################################"

my_program_path="$HOME/.local/bin/"
if [ ! -d "$my_program_path" ]; then
  mkdir $my_program_path
fi

if [ "$1" = "all" ]; then
  $0 xresources
  $0 nautilus_scripts
  $0 firefox_tunnel_to
  $0 alarm
  $0 autoenv
  $0 git_config
  $0 execute_me
  $0 runtime
  $0 autostart_script
fi

if [ "$1" = "xresources" ]; then
  current_dir=$(pwd)
  cd ~/.
  ln -sf $current_dir/.Xresources .Xresources
  xrdb -merge ~/.Xresources #load settings
fi

if [ "$1" = "nautilus_scripts" ]; then
  current_dir=$(pwd)
  cd ~/.local/share/nautilus/scripts
  ln -sf $current_dir/scripts/nautilus/merge_pdf
  ln -sf $current_dir/scripts/nautilus/terminator
fi

if [ "$1" = "firefox_tunnel_to" ]; then
  current_dir=$(pwd)
  cd $my_program_path
  ln -sf $current_dir/scripts/firefox_tunnel_to
fi

if [ "$1" = "alarm" ]; then
  sudo apt-get -y install sharutils
  sudo apt-get -y install redshift

  current_dir=$(pwd)
  cd $my_program_path
  sudo ln -sf $current_dir/scripts/alarm
fi

if [ "$1" = "execute_me" ]; then
  current_dir=$(pwd)
  cd $my_program_path
  ln -sf $current_dir/scripts/execute_me
fi

if [ "$1" = "runtime" ]; then
  current_dir=$(pwd)
  cd $my_program_path
  ln -sf $current_dir/scripts/runtime
fi

if [ "$1" = "git_config" ]; then
  current_dir=$(pwd)
  mkdir -p ~/.config/git/
  cd ~/.config/git/
  ln -sf $current_dir/scripts/git_config config
fi

if [ "$1" = "autostart_script" ]; then
  autostart_file=autostart_script
  touch $my_program_path/$autostart_file
  chmod +x $my_program_path/$autostart_file
cat > $HOME/.config/autostart/${autostart_file}.desktop << EOF
[Desktop Entry]
Name=autostart_script
GenericName=autostart
Comment=Run commands on startup
Exec=${autostart_file}
Terminal=false
Type=Application
Icon=dropbox
Categories=Generic
StartupNotify=false
EOF
fi
