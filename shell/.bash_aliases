# ls
alias ls='ls --color=auto --group-directories-first -FX'
alias la='ls -A'
alias ll='ls -lh'
alias l.='ls -d .[!.]*'

# eza
alias es='eza -F -s type'
alias ea='es -A'
alias el='ea -lgMh'
alias e.='es -d .[!.]*'
alias et='es -T'

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
alias riv='rye init --virtual'
alias lg='lazygit'

