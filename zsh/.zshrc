# Path to your oh-my-zsh installation.
export ZSH="/home/woelke/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="nanotech"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(git cp)

source $ZSH/oh-my-zsh.sh


##################
##-- My Stuff --##
##################

setopt interactivecomments #activate the bash-syle comments, you can run a command with a comment

##-- vim color support --##
export TERM=xterm-256color

##-- generic open cmd --##
alias o='xdg-open'

##-- vim shortcuts --##
alias v="nvr -cc 'call DoLcdToCurrentPath()' --remote $@"
alias vs="nvr -cc 'call DoLcdToCurrentPath()' -o $@"
alias vv="nvr -cc 'call DoLcdToCurrentPath()' -O $@"
alias vt="nvr -cc 'call DoLcdToCurrentPath()' --remote-tab $@"
alias vg='nvim-gtk'

##-- other stuff --##
alias logout='gnome-session-quit'
alias rm='trash'
alias rg='rg --no-messages'

##-- Makefile --##
#run make with flag -j<number of processors>
export MAKEFLAGS="-j$(cat /proc/cpuinfo | grep processor | wc | awk '{ print $1 }')"

