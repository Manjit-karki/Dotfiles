# Environment variables
set -gx MPD_HOST "$HOME/.config/mpd/socket"
set -gx EDITOR nvim

# PATH
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "$HOME/.local/bin"

# Cargo
fish_add_path "$HOME/.cargo/bin"
