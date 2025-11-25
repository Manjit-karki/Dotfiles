#
# ~/.bashrc
#
export MPD_HOST=~/.config/mpd/socket
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

trap '' SIGTSTP

export EDITOR='neovim'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -a'
alias n="nvim"
alias vim="nvim"
alias g="git"
alias hibernate='systemctl hibernate'
alias gitkey='eval "$(ssh-agent -s)"; ssh-add ~/.ssh/key'
alias music="~/.config/scripts/musicinstall.sh"
alias m='rmpc'
alias sysclean='~/.config/scripts/sysmaintenance.sh'
alias sysupdate='~/.config/scripts/update.sh'
alias fetch="fastfetch"
alias stat="gotop"
alias gpu="nvtop"
alias rain='unimatrix -c white'
alias bios='systemctl reboot --firmware-setup'
alias audiofix='~/.config/scripts/audio_reset.sh'

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

fastfetch

eval "$(oh-my-posh init bash --config ~/.poshthemes/bubbles.omp.json)"

# Created by `pipx` on 2025-06-13 14:09:02
export PATH="$HOME/.local/bin:$PATH"

