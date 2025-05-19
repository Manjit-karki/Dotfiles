#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -a' 
alias n="nvim"
alias g="git"



PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"


eval "$(oh-my-posh init bash --config ~/.poshthemes/bubbles.omp.json)"
