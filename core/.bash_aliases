# ls
alias ls='eza -s type'
alias la='ls -A'
alias ll='la -lgMh'
alias l.='ls -d .[!.]*'
alias lt='ls -T'

# cd
alias ,='cd -'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# misc
alias tat='tmux attach'
alias tpi='watch -n1 ping -c1 github.com'
alias dk='docker'
alias dc='docker compose'
alias dcub='docker compose up --build'
alias lg='lazygit'

