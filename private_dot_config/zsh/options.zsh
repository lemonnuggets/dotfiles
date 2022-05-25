setopt autocd               # assume cd when command is directory
setopt histignorealldups    # Substitute commands in the prompt
setopt sharehistory         # Share the same history between all shells
setopt no_beep
setopt menu_complete        # insert first match from possibilities. if request again then replace with second match
setopt inc_append_history   # append to history file whenever a command is run
setopt interactive_comments # allow commands in interactive shell
zle_highlight={'paste:none'}
