# ls
if which eza &> /dev/null ; then
    alias ls='eza -F -s type'
    alias la='ls -A'
    alias ll='la -lgMh'
    alias l.='ls -d .[!.]*'
    alias lt='ls -T'
else
    alias ls='ls -F --sort extension --color=auto'
    alias la='ls -A'
    alias ll='ls -lh'
    alias l.='ls -d .[!.]*'
fi


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
alias dcb='docker compose build'
alias dcp='docker compose pull'
alias riv='rye init --virtual'
alias lg='lazygit'

