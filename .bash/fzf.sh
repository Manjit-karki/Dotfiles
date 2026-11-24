# FZF shell integration

eval "$(fzf --bash)"

# Completion appearance
export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS='--border --info=inline'

# Default appearance
export FZF_DEFAULT_OPTS='
    --height 60%
    --layout=reverse
    --border=rounded
    --info=inline
'
