# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

_addpath() {
  local -n _var=$1
  case ":$_var:" in
    *":$2:"*) ;;
    *) _var="$2:$_var" ;;
  esac
  export "$1"
}
_addpath PATH /sbin
_addpath PATH /usr/sbin
_addpath PATH "$HOME/bin"
_addpath PATH "$HOME/.local/bin"

_hascmd() { command -v "$1" &>/dev/null; }
# default visual editor
export VISUAL=nano
_hascmd nvim && VISUAL=nvim
export EDITOR=$VISUAL

_source() {
  [[ -r "$1" ]] && bash -n "$1" && . "$1"
}
_source "$HOME/.bash_aliases"

#--------------------------------------------------------------------------------
_source "$HOME/.lapt/env"

export JAVA_HOME="$HOME/.jvm/21"
_addpath PATH "$JAVA_HOME/bin"

export NNN_BMS="h:$HOME;c:$HOME/.config;l:$HOME/.local"

glm(){
  GLM_API_KEY="$(ksp 'Personal/GLM Token')"
  ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" \
  ANTHROPIC_AUTH_TOKEN=$GLM_API_KEY \
  ANTHROPIC_DEFAULT_HAIKU_MODEL=glm-5.3-flash \
  ANTHROPIC_DEFAULT_SONNET_MODEL=glm-5.3 \
  ANTHROPIC_DEFAULT_OPUS_MODEL=glm-5.3 \
  claude $1
}

#--------------------------------------------------------------------------------
# If not running interactively, don't do anything below
case $- in
  *i*) ;;
  *) return ;;
esac

_source /etc/bash_completion

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# colors
nc='\[\033[0m\]'
black='\[\033[0;30m\]'
BLACK='\[\033[1;30m\]'
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
blue='\[\033[0;34m\]'
BLUE='\[\033[1;34m\]'
pink='\[\033[0;35m\]'
PINK='\[\033[1;35m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
gray='\[\033[0;37m\]'
GRAY='\[\033[1;37m\]'

# prompt and title
case "$TERM" in
  xterm-color | *-256color) color_prompt=yes ;;
esac

chroot=
chroot_prompt="${chroot:+($chroot)}"

if [ "$color_prompt" = yes ]; then
  PS1="$chroot_prompt$CYAN\u$YELLOW@$GREEN\h$nc:$PINK\w$nc\n$RED\$$nc "
else
  PS1="$chroot_prompt\u@\h:\w\n\$ "
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;$chroot_prompt\u@\h: \w\a\]$PS1" ;;
  *) ;;
esac

unset nc black BLACK red RED green GREEN yellow YELLOW blue BLUE pink PINK cyan CYAN gray GRAY
unset color_prompt chroot_prompt

