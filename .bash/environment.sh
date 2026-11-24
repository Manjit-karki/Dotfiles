# Environment variables
export MPD_HOST="$HOME/.config/mpd/socket"
export EDITOR='nvim'

# PATH
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Cargo
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
