# My Dotfiles

## Introduction

This is my Dotfile project. I store these files on Github just for myself, but of course I do not forbid to use it or snatch ideas from it.

My Dotfiles contain a quite complex vim and zsh configuration, my favorite Linux programmes.

## Requirements

- Python installer
```sh
    pacman -S python-pipx
```

- Github access via ssh key (needed for zsh)

## Startup

Run the following commands to bootstrap dotfiles:

```sh
    git clone git@github.com:woelke/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./bootstrap.sh
```

## Other configurations

Swap ESC and Caps Lock

    #gnome-tweaks: Keyboard -> Additional Layout Options -> Caps Lock key behavior -> Swap ESC and Caps Lock

Set Keyboard Layout EurKey 

    #gnome-tweaks: Keyboard -> Show Extended Input Sources
    #settings: Keyboard -> Input Sources -> English -> EurKEY (US)
