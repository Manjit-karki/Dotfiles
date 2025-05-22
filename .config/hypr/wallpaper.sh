wallpaper_dir="$HOME/Dotfiles/.config/wallpaper"

menu(){
	find "${wallpaper_dir}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}

main() {
	choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
	selected_wallpaper=$(echo "$choice" | sed 's/^img://')
	swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
	wal -i "$selected_wallpaper" -n --cols16
	swaync-client --reload-css
	color1=$(awk 'match($0, /color2=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
	color2=$(awk 'match($0, /color3=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
	source ~/.cache/wal/colors.sh && cp -r $wallpaper ~/.config/wallpaper/1.jpg
}
main
