
#!/usr/bin/env bash

# ==========================================
# Dotfiles Installer
# Repository: Dotfiles
# Arch Linux + Hyprland
# ==========================================

set -Eeuo pipefail

# ==========================================
# COLORS
# ==========================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'
BOLD='\033[1m'

# ==========================================
# PATHS
# ==========================================

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# ==========================================
# PACKAGE LISTS
# ==========================================

OFFICIAL_PACKAGES=(

    # Essential utilities
    base-devel
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


    # Display manager
    sddm

    # Terminal and desktop
    kitty
    waybar
    wofi
    python-pywal
    mpd
    nautilus
    xdg-user-dirs


    # Screenshots and clipboard
    grim
    slurp
    wl-clipboard

)

AUR_PACKAGES=(
    wlogout
    swaync
    awww
    sddm-silent-theme-git
)

# ==========================================
# HELPERS
# ==========================================

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

ask() {
    local answer
    read -r -p "$(echo -e "${YELLOW}[?]${RESET} $1 [y/N]: ")" answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

# ==========================================
# SYSTEM CHECKS
# ==========================================

check_system() {

    if [[ ! -f /etc/arch-release ]]; then
        error "This installer is intended for Arch Linux."
        exit 1
    fi

    if [[ $EUID -eq 0 ]]; then
        error "Do not run this script as root."
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

    if ! command -v pacman &>/dev/null; then
        error "pacman is unavailable."
        exit 1
    fi

    if ! command -v ping &>/dev/null ||
       ! ping -c 1 -W 3 archlinux.org &>/dev/null; then
        error "No internet connection detected."
        exit 1
    fi

    success "System checks passed."
}

# ==========================================
# PACKAGE INSTALLATION
# ==========================================

install_official() {

    info "Updating system and installing official packages..."

    sudo pacman -Syu --needed --noconfirm \
        "${OFFICIAL_PACKAGES[@]}"

    success "Official packages installed."
}

# ==========================================
# INSTALL YAY
# ==========================================

install_yay() {

    if command -v yay &>/dev/null; then
        success "yay is already installed."
        return
    fi

    info "Installing yay..."

    local build_dir
    build_dir="$(mktemp -d)"

    git clone https://aur.archlinux.org/yay.git "$build_dir/yay"

    (
        cd "$build_dir/yay"
        makepkg -si --noconfirm
    )

    rm -rf "$build_dir"

    success "yay installed."
}

# ==========================================
# AUR PACKAGES
# ==========================================

install_aur() {

    info "Installing AUR packages..."

    yay -S --needed --noconfirm \
        "${AUR_PACKAGES[@]}"

    success "AUR packages installed."
}

# ==========================================
# ENABLE SERVICES
# ==========================================

enable_services() {

    info "Configuring system services..."

    sudo systemctl enable --now NetworkManager.service
    sudo systemctl enable --now bluetooth.service

    if ask "Enable SDDM as the display manager?"; then
        sudo systemctl enable sddm.service
        success "SDDM enabled."
    fi

    success "Services configured."
}

# ==========================================
# USER DIRECTORIES
# ==========================================

setup_directories() {

    info "Creating user directories..."

    xdg-user-dirs-update

    success "User directories created."
}

# ==========================================
# BACKUP HANDLING
# ==========================================

backup_item() {

    local target="$1"

    mkdir -p "$BACKUP_DIR"

    warning "Existing configuration found: $target"

    if ask "Back up and replace it?"; then
        mv -- "$target" "$BACKUP_DIR/"
        success "Backed up: $target"
        return 0
    else
        warning "Skipped: $target"
        return 1
    fi
}

# ==========================================
# SYMLINK HANDLER
# ==========================================

link_item() {

    local source="$1"
    local target="$2"

    if [[ ! -e "$source" ]]; then
        warning "Source not found: $source"
        return 0
    fi

    # Already correctly linked
    if [[ -L "$target" ]] &&
       [[ "$(readlink -f -- "$target")" == "$(readlink -f -- "$source")" ]]; then

        success "Already installed: $target"
        return 0
    fi

    # Handle existing files/directories
    if [[ -e "$target" || -L "$target" ]]; then
        backup_item "$target" || return 0
    fi

    ln -s -- "$source" "$target"

    success "Installed: $target"
}

# ==========================================
# INSTALL CONFIGURATIONS
# ==========================================

install_configs() {

    info "Installing configurations..."

    mkdir -p "$CONFIG_DIR"

    for item in "$DOTFILES_DIR/.config/"*; do

        [[ -e "$item" ]] || continue

        local name
        name="$(basename "$item")"

        link_item "$item" "$CONFIG_DIR/$name"

    done

    success "Configurations installed."
}

# ==========================================
# INSTALL OTHER DOTFILES
# ==========================================

install_other_dotfiles() {

    info "Installing additional dotfiles..."

    link_item "$DOTFILES_DIR/.poshthemes" "$HOME/.poshthemes"

}

# ==========================================
# MAIN
# ==========================================

main() {

    clear

    echo -e "${BLUE}${BOLD}"
    echo "=========================================="
    echo "          DOTFILES INSTALLER"
    echo "=========================================="
    echo -e "${RESET}"

    check_system

    echo
    info "Repository: $DOTFILES_DIR"
    info "Target: $HOME"
    echo

    if ! ask "Install packages and apply dotfiles?"; then
        warning "Installation cancelled."
        exit 0
    fi

    # Install packages
    install_official

    install_yay

    install_aur

    # Configure services
    enable_services

    # Configure user directories
    setup_directories

    # Install dotfiles
    install_configs

    install_other_dotfiles

    # Finish
    echo
    echo -e "${GREEN}${BOLD}"
    echo "=========================================="
    echo "       INSTALLATION COMPLETED!"
    echo "=========================================="
    echo -e "${RESET}"

    if [[ -d "$BACKUP_DIR" ]]; then
        info "Backups saved at: $BACKUP_DIR"
    fi

    echo
    info "Please reboot your system."
}

main "$@"

