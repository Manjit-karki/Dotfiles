#
# ~/.bashrc
#

# Load only in interactive shells
[[ $- != *i* ]] && return

# Load modular configuration
for file in "$HOME"/.bash/*.sh; do
    [[ -r "$file" ]] && source "$file"
done

