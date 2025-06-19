#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -a'
alias n="nvim"
alias vim="nvim"
alias g="git"
alias hibernate='sudo systemctl hibernate'
alias gitkey='eval "$(ssh-agent -s)"; ssh-add ~/.ssh/key'
alias music="rmpc"
alias m="rmpc"
alias sysmaintain='~/Dotfiles/sysmaintenance.sh'
alias fetch="fastfetch"
alias rain='unimatrix -c white'

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

eval "$(oh-my-posh init bash --config ~/.poshthemes/bubbles.omp.json)"

# Created by `pipx` on 2025-06-13 14:09:02
export PATH="$PATH:/home/katsumi/.local/bin"
