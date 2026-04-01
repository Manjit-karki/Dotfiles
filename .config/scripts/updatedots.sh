#!/usr/bin/env bash

set -e

CONFIG_DIR="$HOME/.config"
DOT="$HOME/Dotfiles/.config"

# Copy .bashrc
cp "$HOME/.bashrc" "$HOME/Dotfiles/"

# Copy config folders
dirs=(hypr kitty nvim fastfetch waybar wlogout wal wallpaper wofi scripts mpd)

for d in "${dirs[@]}"; do
    [ -d "$CONFIG_DIR/$d" ] && cp -r "$CONFIG_DIR/$d" "$DOT/"
done

# Remove mpd metadata 
rm -rf "$DOT/mpd/database" \
       "$DOT/mpd/log" \
       "$DOT/mpd/state" \
       "$DOT/mpd/sticker.sql"

echo "Done."
