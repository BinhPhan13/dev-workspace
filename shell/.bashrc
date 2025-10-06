# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# bash-completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

# aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

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

# default visual editor
export VISUAL=vi

# add to PATH
addpath() {
  if [ -d $1 ]; then
    echo $PATH | grep -Eq "(^|:)$1(:|$)" || PATH=$1:$PATH
  fi
}
addpath $HOME/.local/bin
# sbin directories, useful on systems that have sudo
addpath /sbin
addpath /usr/sbin

