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
plugins=(git
  cp
  autojump
  docker
  vi-mode
  sudo
  zsh-aliases-lsd
  zsh-autosuggestions
  ripgrep
  fd
  fzf
  zsh-syntax-highlighting # musst be the last
)

source $ZSH/oh-my-zsh.sh

##################
##-- My Stuff --##
##################

##-- fzf --##
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --info=inline"
export FZF_ALT_C_OPTS="--select-1 --exit-0 --info=inline"

# CTRL-T command
export FZF_CTRL_T_COMMAND="fd --type f --hidden --exclude .git --exclude .npm"
# ALT-C command
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git --exclude .npm"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    env)          env | bat --color=always --language=bash --paging=never --plain | fzf --ansi --height=50% ;;
    *)            fd . -t f | fzf "$@" --height=90% --preview-window=down,40% --preview 'bat --color=always --line-range :150 {}' ;;
  esac
}

##-- zsh-autosuggestions --##
# use shift tab to accept a suggestion
bindkey '^[[Z' autosuggest-accept

# Strategies to use to fetch a suggestion
# Will try each strategy in order until a suggestion is returned
(( ! ${+ZSH_AUTOSUGGEST_STRATEGY} )) && {
	typeset -ga ZSH_AUTOSUGGEST_STRATEGY
	ZSH_AUTOSUGGEST_STRATEGY=(history completion)
}

##-- add sudo in front of the cmd with hostkey Ctrl+CR --##
bindkey -M vicmd '^[[13;5u' sudo-command-line
bindkey -M viins '^[[13;5u' sudo-command-line

##-- bat a replacement for cat --##
export BAT_THEME="TwoDark"
alias cat='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

setopt interactivecomments #activate the bash-syle comments, you can run a command with a comment

##-- color support --##
export TERM=xterm-256color
export LS_COLORS="$(vivid generate one-dark)"

##-- generic open cmd --##
alias o='xdg-open'

##-- vim shortcuts --##
alias v="nvr -cc 'call DoLcdToCurrentPath()' --remote $@"
alias vs="nvr -cc 'call DoLcdToCurrentPath()' -o $@"
alias vv="nvr -cc 'call DoLcdToCurrentPath()' -O $@"
alias vt="nvr -cc 'call DoLcdToCurrentPath()' --remote-tab $@"
alias vg="neovide"
#alias vg="nvim-gkt"

##-- other stuff --##
alias logout='gnome-session-quit'
alias rm='trash'
alias rg='rg --no-messages'

##-- Makefile --##
#run make with flag -j<number of processors>
export MAKEFLAGS="-j$(cat /proc/cpuinfo | grep processor | wc | awk '{ print $1 }')"
