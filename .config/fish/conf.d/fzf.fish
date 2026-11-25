# FZF shell integration
fzf --fish | source

# Completion appearance
set -gx FZF_COMPLETION_OPTS '--border --info=inline'

# Default appearance
set -gx FZF_DEFAULT_OPTS '
    --height 60%
    --layout=reverse
    --border=rounded
    --info=inline
'
