set -e

# remvoing .git folder
rm -rf .git

#update system pacman

echo ""
echo "----------------------------------------------------"
echo "UPDATING SYSTEM"
echo "----------------------------------------------------"
echo ""

sudo pacman -Syu --noconfirm

# setting up the system for basic development
# installing coding languages and packages
echo ""
echo "----------------------------------------------------"
echo "Installing development packages and languages"
echo "----------------------------------------------------"
echo ""

sudo pacman -S --needed base-devel git wget curl unzip zip tar fastfetch btop fzf \
  neovim vim code gcc clang gdb lldb cmake make lua luarocks jdk-openjdk python \
  python-pip nodejs npm vite create-react-app eslint kitty dkms docker dosfstools dunst \
  efibootmgr ninja network-manager-applet networkmanager ntfs-3g python-pipx \
  python-pywal python-virtualenv

echo ""
echo "----------------------------------------------------"
echo "Installing Rust/Cargo"
echo "----------------------------------------------------"
echo ""

if ! command -v rustc >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "----------------------------------------------------"
  echo "Rust already installed, skipping "
  echo "----------------------------------------------------"
fi

#source cargo environment

source "$HOME/.cargo/env"

# other important installations
echo ""
echo "----------------------------------------------------"
echo "BUILDING DEPENDENCIES"
echo "----------------------------------------------------"
echo ""
echo "----------------------------------------------------"
echo "Installing Desktop environment & additional packages"
echo "----------------------------------------------------"
echo ""

sudo pacman -S --needed hyprland hyprlock hyprpaper swww sway sddm wofi waybar \
  firefox chromium mpd rmpc nautilus dolphin discord hyprshot mousepad \
  noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra oh-my-posh-bin slurp \
  smartmontools swaync ttf-dejavu ttf-hack ttf-hack-nerd unimatrix-git yay cliphist

#enabling services

echo ""
echo "----------------------------------------------------"
echo "Enabling and starting necessary system services "
echo "----------------------------------------------------"
echo ""

sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

sudo systemctl enable docker.service
sudo systemctl start docker.service

sudo systemctl enable sddm.service
sudo systemctl start sddm.service

sudo systemctl enable mpd.service
sudo systemctl start mpd.service

sudo systemctl --user enable pipewire pipewire-pulse wireplumber
sudo systemctl --user start pipewire pipewire-pulse wireplumber

# Creating simlinks

echo ""
echo "----------------------------------------------------"
echo "CREATING SIMLINKS"
echo "----------------------------------------------------"
echo ""
ln -sf "$HOME/Dotfiles/.bashrc" "$HOME/.bashrc"
ln -sf "$HOME/Dotfiles/.config/hypr" "$HOME/.config/hypr"
ln -sf "$HOME/Dotfiles/.config/lock" "$HOME/.config/lock"
ln -sf "$HOME/Dotfiles/.config/wal" "$HOME/.config/wal"
ln -sf "$HOME/Dotfiles/.config/wallpaper" "$HOME/.config/wallpaper"
ln -sf "$HOME/Dotfiles/.config/kitty" "$HOME/.config/kitty"
ln -sf "$HOME/Dotfiles/.config/waybar" "$HOME/.config/waybar"
ln -sf "$HOME/Dotfiles/.config/wofi" "$HOME/.config/wofi"
ln -sf "$HOME/Dotfiles/.config/fastfetch" "$HOME/.config/fastfetch"

#rebooting

echo ""
echo "----------------------------------------------------"
echo "INSTALLATIONS COMPLETE"
echo "----------------------------------------------------"
echo ""
echo "----------------------------------------------------"
echo "INITIATING SYSTEM REBOOT"
echo "----------------------------------------------------"
sudo reboot
