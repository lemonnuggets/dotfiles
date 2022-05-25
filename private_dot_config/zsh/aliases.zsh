# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# ls aliases
alias l='ls -lFh --color=auto'					# long list, show type, human readable
alias la='ls -lFhA --color=auto'				# long list, show type, human readable, show almost all
alias lt='ls -tFh --color=auto'					# sort by date, show type, human readable
alias lr='ls -tFhR --color=auto'				# sort by date, show type, human readable, recursive

# less aliases
alias less='less -R'

# neovim
alias vi="nvim"
alias vim="nvim"
alias vedit=" $EDITOR $HOME/.config/nvim"

# grep
alias grep='grep --color=auto'

# mupdf
alias mupdf='mupdf "$(fzf)"'

# edit zsh
alias aedit="$EDITOR $ZSH_CONFIG/aliases.zsh; source $ZSH_CONFIG/aliases.zsh"
alias fedit="$EDITOR $ZSH_CONFIG/functions.zsh; source $ZSH_CONFIG/functions.zsh"
alias eedit="$EDITOR $ZSH_CONFIG/environment.zsh; source $ZSH_CONFIG/environment.zsh"
alias oedit="$EDITOR $ZSH_CONFIG/options.zsh; source $ZSH_CONFIG/options.zsh"
alias kedit="$EDITOR $ZSH_CONFIG/keybinds.zsh; source $ZSH_CONFIG/keybinds.zsh"
alias cedit="$EDITOR $ZSH_CONFIG/completions/completion.zsh; source $ZSH_CONFIG/completions/completion.zsh"
alias zedit="$EDITOR $HOME/.zshrc"
alias zsh-update-plugins="find '$ZSH_CONFIG/plugins' -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# pacman
# alias pacman-backup="mkdir -p $HOME/.backup/pacman; pacman -Qqen > $HOME/.backup/pacman/pkglist.txt"
# alias pacman-backup-local="mkdir -p $HOME/.backup/pacman; pacman -Qqem > $HOME/.backup/pacman/localpkglist.txt"
# alias pacman-restore="sudo pacman -S --needed $(comm -12 <(pacman -Slq|sort) <(sort $HOME/.backup/pacman/pkglist.txt) )"
# alias pacman-restore-local="yay -S --noeditmenu --noconfirm --needed $HOME/.backup/pacman/localpkglist.txt"   # yay is required

# misc
alias cls='clear'
alias e='echo'
alias clip="xclip -selection clipboard"
alias path="e $PATH | sed s/\:/\\\n/g"
# alias fpath="e $fpath | sed s/ /\\\n/g"
alias refresh="exec '$SHELL'"
alias weather="$ZSH_CONFIG/wttr.sh"
