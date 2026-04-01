#!/bin/bash
WALLPAPER_DIR="$HOME/.config/wallpaper"

menu() {
  find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}
main() {
  choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
  selected_wallpaper=$(echo "$choice" | sed 's/^img://')
  awww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
  convert "$selected_wallpaper" -resize 800x600 ~/.cache/wal/tmpwallpaper.jpg
  wal -i "$selected_wallpaper" -n
  swaync-client --reload-css
  cat ~/.cache/wal/colors-kitty.conf >~/.config/kitty/current-theme.conf
  pywalfox update
  pkill waybar
  waybar &
  source ~/.cache/wal/colors.sh
  cp -r "$selected_wallpaper" ~/.config/wallpaper/pywallpaper.jpg
}
main
