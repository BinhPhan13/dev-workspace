# ls
alias ls='ls --color=auto --group-directories-first -Fv'
alias l='ls -lh'
alias la='l -A'
alias l.='l -d .[!.]*'
alias lt='eza -T -F -s type'

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

# misc
alias tpi='watch -n1 ping -c1 github.com'
alias tat='tmux attach'
alias lg='lazygit'

