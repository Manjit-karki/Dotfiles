#!/usr/bin/env bash

set -Eeuo pipefail

# ==========================================
# PERSONAL ARCH SETUP
# ==========================================

SCRIPT_NAME="Personal Setup"

# ------------------------------------------
# COLORS
# ------------------------------------------

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

info() {
    echo -e "${BLUE}[INFO]${RESET} $1"
}

success() {
    echo -e "${GREEN}[OK]${RESET} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${RESET} $1"
}

error() {
    echo -e "${RED}[ERROR]${RESET} $1"
}

# ------------------------------------------
# PACKAGE LISTS
# ------------------------------------------

OFFICIAL_PACKAGES=(
    # Base system
    base
    base-devel
    linux
    linux-firmware
    linux-headers

    # Bootloader utilities
    grub
    efibootmgr
    dosfstools
    exfatprogs
    mtools
    ntfs-3g

    # Networking
    networkmanager

    # NVIDIA
    nvidia-open
    nvidia-utils
    nvidia-settings

    # Hyprland
    hyprland
    uwsm
    wayland
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # Display manager
    sddm

    # Terminal and desktop
    kitty
    waybar
    wofi
    dolphin
    dolphin-plugins
    nautilus
    xdg-user-dirs

    # Audio
    pipewire
    pipewire-pulse
    pipewire-alsa
    wireplumber
    alsa-utils
    pavucontrol

    # Bluetooth
    bluez
    bluez-utils

    # Input
    keyd

    # Fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    ttf-hack-nerd

    # Themes
    adw-gtk-theme
    papirus-icon-theme
    bibata-cursor-theme

    # Essential utilities
    sudo
    git
    wget
    fastfetch
    btop
    fd
    fzf
    ripgrep
    vim
    neovim
)

AUR_PACKAGES=(
    sddm-silent-theme-git
)

# ------------------------------------------
# CHECKS
# ------------------------------------------

check_system() {
    if [[ ! -f /etc/arch-release ]]; then
        error "This script is intended for Arch Linux."
        exit 1
    fi

    if [[ $EUID -eq 0 ]]; then
        error "Do not run this script as root."
        error "Run it as your normal user."
        exit 1
    fi

    if ! command -v sudo &>/dev/null; then
        error "sudo is not installed."
        exit 1
    fi

    if ! sudo -v; then
        error "Unable to obtain sudo privileges."
        exit 1
    fi

    if ! ping -c 1 -W 3 archlinux.org &>/dev/null; then
        error "No internet connection detected."
        exit 1
    fi

    success "System checks passed."
}

# ------------------------------------------
# SYSTEM UPDATE
# ------------------------------------------

update_system() {
    info "Updating Arch Linux..."

    sudo pacman -Syu --noconfirm

    success "System updated."
}

# ------------------------------------------
# OFFICIAL PACKAGES
# ------------------------------------------

install_official() {
    info "Installing official repository packages..."

    sudo pacman -S --needed --noconfirm \
        "${OFFICIAL_PACKAGES[@]}"

    success "Official packages installed."
}

# ------------------------------------------
# INSTALL YAY
# ------------------------------------------

install_yay() {
    if command -v yay &>/dev/null; then
        success "yay is already installed."
        return
    fi

    info "Installing yay..."

    local build_dir
    build_dir=$(mktemp -d)

    git clone https://aur.archlinux.org/yay.git "$build_dir/yay"

    (
        cd "$build_dir/yay"
        makepkg -si --noconfirm
    )

    rm -rf "$build_dir"

    success "yay installed."
}

# ------------------------------------------
# AUR PACKAGES
# ------------------------------------------

install_aur() {
    info "Installing AUR packages..."

    yay -S --needed --noconfirm \
        "${AUR_PACKAGES[@]}"

    success "AUR packages installed."
}

# ------------------------------------------
# ENABLE SERVICES
# ------------------------------------------

enable_services() {
    info "Enabling system services..."

    sudo systemctl enable --now NetworkManager.service
    sudo systemctl enable --now bluetooth.service

    # Enable SDDM for the next boot.
    sudo systemctl enable sddm.service

    success "Services configured."
}

# ------------------------------------------
# USER DIRECTORIES
# ------------------------------------------

setup_directories() {
    info "Creating user directories..."

    xdg-user-dirs-update

    success "User directories created."
}

# ------------------------------------------
# MAIN
# ------------------------------------------

main() {
    clear

    echo -e "${BLUE}"
    echo "=========================================="
    echo "       ARCH PERSONAL INSTALLER"
    echo "=========================================="
    echo -e "${RESET}"

    check_system

    update_system

    install_official

    install_yay

    install_aur

    enable_services

    setup_directories

    echo
    success "Arch Linux setup completed!"
    info "Please reboot your system."
}

main "$@"

