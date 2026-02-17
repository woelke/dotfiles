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
plugins=(
  git
  docker
  docker-compose
  vi-mode
  sudo
  zsh-aliases-lsd
  zsh-autosuggestions
  fzf
  zsh-syntax-highlighting # musst be the last
)

# zsh-completions cannot be added directly to the plugins
# thats why we have to use the fpath
# souce: https://github.com/zsh-users/zsh-completions/issues/603
fpath+="${ZSH_CUSTOM:-"$ZSH/custom"}/plugins/zsh-completions/src"

source $ZSH/oh-my-zsh.sh

##################
##-- My Stuff --##
##################

##-- zsh completion details --##
# source: https://thevaluable.dev/zsh-completion-guide-examples/
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}-- %d (typos: %e) --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands #<-- might not work???

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

##-- fzf --##
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --inline-info'
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --inline-info"
export FZF_ALT_C_OPTS="--select-1 --exit-0 --inline-info --preview 'tree -C {}'"

# CTRL-T command
export FZF_CTRL_T_COMMAND="fd --type f --hidden --exclude .git --exclude .npm"
# ALT-C command
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git --exclude .npm"

_fzf_comprun() {
  local command=$1
  shift

  local fzf_cmd='fzf --ansi --height=70%'
  local fzf_bat='bat --color=always --paging=never --plain'
  local fzf_bash_cmd="${fzf_bat} --language=bash | ${fzf_cmd}"

  case "$command" in
    env)          env | sort | eval $fzf_bash_cmd ;;
    alias)        alias | sort | eval $fzf_bash_cmd ;;
    mount)        mount | eval "${fzf_bat} --language=ini" | eval "${fzf_cmd}" ;;
    kill)         echo "$(ps -ef | sed '1d' | awk '{$1=""; for (i=3; i<=7; i++) $i=""; print}' | eval "$fzf_bash_cmd --multi --header='PID CMD'"| awk '{print $1, $1}')";;
        # note: kill ** interfers with /usr/share/fzf/completion.zsh function _fzf_complete_kill[_post]
  esac
}

# overwrite widget from /usr/share/fzf/key-bindings.zsh
# cd-widget changes dir automatically on an empty buffer
# otherwise insertes the selected folder at the current cursor position
fzf-cd-widget() {
  local cmd=$FZF_ALT_C_COMMAND
  local lbuf=$LBUFFER
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi

  if [[ -z "$BUFFER" ]]; then
    BUFFER="builtin cd -- ${(q)dir}"
    zle accept-line
  else
    LBUFFER="$LBUFFER ${(q)dir} "
    zle end-of-line
  fi

  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}

# overwrite widget from /usr/share/fzf/key-bindings.zsh
# fzf-file-widget (CTRL-T) - Paste the selected file path(s) into the command line
export CTRL_T_CMD="v "

fzf-file-widget() {
  if [[ -z "$BUFFER" ]]; then
    BUFFER="$CTRL_T_CMD $(__fzf_select)"
    zle accept-line
  else
    LBUFFER="$LBUFFER $(__fzf_select)"
    zle end-of-line
  fi

  local ret=$?
  zle reset-prompt
  return $ret
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
export BAT_THEME="Catppuccin Macchiato"
alias cat='bat'
export MANPAGER='nvim +Man!'

##-- generic open cmd --##
alias o='xdg-open'

##-- vim shortcuts --##
alias v="nvr -cc 'call DoLcdToCurrentPath()' --remote $@"
alias vs="nvr -cc 'call DoLcdToCurrentPath()' -o $@"
alias vv="nvr -cc 'call DoLcdToCurrentPath()' -O $@"
alias vt="nvr -cc 'call DoLcdToCurrentPath()' --remote-tab $@"
alias vg="neovide"

##-- other stuff --##
alias logout='gnome-session-quit'
alias rm='trash'
alias rg='rg --no-messages'
setopt interactivecomments #activate the bash-syle comments, you can run a command with a comment

# If the last character of the alias value is a blank, then the next command word following the alias is also checked for alias expansion.
alias sudo='sudo '

##-- Makefile --##
#run make with flag -j<number of processors>
export MAKEFLAGS="-j$(cat /proc/cpuinfo | grep processor | wc | awk '{ print $1 }')"

##-- pacdiff --##
export DIFFPROG='nvim -d'
