# XDG Base Directory Specification
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# executable search path
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/sbin:$PATH

# tools
export EDITOR=nvim
export TERMINAL="kitty"
export BROWSER="brave"

# zsh
export ZSH_CONFIG="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE

## history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=$ZSH_CACHE/history

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# fnm
export FNM_ROOT="$HOME/.fnm"
command -v fnm >/dev/null || export PATH="$FNM_ROOT:$PATH"

# googler -- rofi-search
export GOOGLE_ARGS='["--count", 5]'
export ROFI_SEARCH='googler'

# git configuration manager
export GCM_CREDENTIAL_STORE=cache

# auto-notify
export AUTO_NOTIFY_THRESHOLD=10
export AUTO_NOTIFY_TITLE="Hey! %command has just finished"
export AUTO_NOTIFY_BODY="It completed in %elapsed seconds with exit code %exit_code"
export AUTO_NOTIFY_EXPIRE_TIME=15000
AUTO_NOTIFY_IGNORE+=("man" "nvim")

