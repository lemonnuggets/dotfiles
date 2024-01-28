alias aedit="$EDITOR $ZDOTDIR/alias.zsh"
alias eedit="$EDITOR $ZDOTDIR/env.zsh"
alias zedit="$EDITOR $ZDOTDIR"

alias convert2pdf="libreoffice --headless --convert-to pdf"

alias update-mirrors="~/.scripts/update-mirrors.sh"

alias refresh="exec $SHELL"

# List all files (*) and directories (/) with human readable size
alias ll='ls -lahF --color=auto'
# Gets a list of existing directories from current folder.
alias ld='ls -d */'
# List files and folders sorted by size
alias lsize='du -sh * | sort -rh'
# List all files (*) and directories (/) with human readable size, sorted by date modified
alias ltime='ls -lAahtF --color=auto'
# Gets a total recursirve count of existing files, no folders.
alias lcf='find . -type f | wc -l'

# to create clojure nrepl
alias clj-nrepl="clojure -Sdeps '{:deps {nrepl {:mvn/version \"0.7.0\"} cider/cider-nrepl {:mvn/version \"0.25.2\"}}}' -m nrepl.cmdline --middleware '[\"cider.nrepl/cider-middleware\"]'"

# so that aliases can be used with sudo
# https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
# archived link: https://web.archive.org/web/20231207161629/https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo="sudo "

