# General

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -a'

# Applications
alias F='nautilus'
alias n='nvim'
alias vim='nvim'
alias g='git'
alias m='rmpc'
alias fetch='fastfetch'
alias stat='btop'
alias rain='unimatrix -c white'
alias anime='ani-cli'

# System
alias bios='systemctl reboot --firmware-setup'
alias wifi='nmcli device wifi connect "Katsumi"'

# Custom scripts
alias music='~/.config/scripts/musicinstall.sh'
alias sysclean='~/.config/scripts/sysmaintenance.sh'
alias sysupdate='~/.config/scripts/update.sh'
alias audiofix='~/.config/scripts/audio_reset.sh'
alias Dots='~/.config/scripts/updatedots.sh'

# SSH
alias gitkey='eval "$(ssh-agent -s)"; ssh-add ~/.ssh/key'

# Notes
alias notepull='~/.config/scripts/pull.sh'
alias notepush='~/.config/scripts/push.sh'
