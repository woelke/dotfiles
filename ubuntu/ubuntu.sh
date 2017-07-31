#!/bin/bash

if [ "$1" = "all" ]; then
  ./ubuntu.sh system_sounds
fi

if [ "$1" = "system_sounds" ]; then
  cd /usr/share/sounds/freedesktop/stereo
  sudo mkdir backup
  sounds="audio-volume-change.oga" 

  for sound in $sounds; do
    sudo mv $sound backup/.
  done
fi

