#!/bin/bash

read -p "Do you want to backup your current .config directory? (y/n, default: y): " backup_choice
backup_choice=${backup_choice:-y}  # Default to 'y' if empty
if [[ "$backup_choice" == "y" ]]; then
    cp -r ~/.config ~/.config_backup
    echo "Backup of .config created at ~/.config_backup"
fi

# Package install section

sudo pacman -S --needed git base-devel python lua jdk-openjdk vim firefox kitty curl 

#installing yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


#AUR and Packages install section
yay -S swww waybar swaync fastfetch neovim python-pywalfox wlogout cava spotify discord blueman /
bluez pavucontrol unimatrix-git protonup-qt obsidian heroic-games-launcher-bin driodcam swappy / 
steam rmpc python-pipx python-pywal python-spotdl
