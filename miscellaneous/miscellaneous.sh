#!/bin/bash

echo "####################################"
echo "## $0 $@"
echo "####################################"

my_program_path="$HOME/.local/bin/"
if [ ! -d "$my_program_path" ]; then
  mkdir $my_program_path
fi

if [ "$1" = "all" ]; then
  $0 firefox_tunnel_to
fi

if [ "$1" = "firefox_tunnel_to" ]; then
  current_dir=$(pwd)
  cd $my_program_path
  ln -sf $current_dir/scripts/firefox_tunnel_to
fi
