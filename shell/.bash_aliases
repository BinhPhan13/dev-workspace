# ls
alias ls='ls --color=auto --group-directories-first -Fv'
alias l='ls -lh'
alias la='l -A'
alias l.='l -d .[!.]*'

# cd
alias ,='cd -'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# docker
alias dc='docker compose'
alias dcb='docker compose build'
alias dcp='docker compose pull'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit'

# keepassxc
alias ksp='keepassxc cli show -a Password ~/.keepassxc/ioub.kdbx'

# misc
alias tpi='watch -n1 ping -c1 google.com'
alias tat='tmux new-session -A'

alias lg='lazygit'
alias uvr='uv run'
alias stl='systemctl'
alias rsf='rsync -aHAXxv'
alias ibr='ibus-daemon -rdx'

alias sudo="sudo "
alias S='[[ $(tty) =~ /dev/tty ]] && startxfce4'
