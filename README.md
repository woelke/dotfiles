# My Dotfiles

## Introduction

This is my Dotfile project. I store these files on Github just for myself, but of course I do not forbid to use it or snatch ideas from it.

My Dotfiles contain a quite complex vim and zsh configuration, my favorite Linux programmes.

## Requirements

```sh
    pacman -S python-pipx
```

## Startup

Run the following commands to configure all automatically:

    git clone https://github.com/aufgang001/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./bootstrap.sh

## Other configurations

Swap ESC and Caps Lock

    #gnome-tweak: Keyboard & Mouse -> Additional Layout Options -> Caps Lock key behavior -> Swap ESC and Caps Lock

Set Keyboard Layout EurKey 

    #gnome-tweak: Keyboard & Mouse -> Show Extended Input Sources
    #settings: Keyboard -> Input Sources -> English -> EurKEY (US)
