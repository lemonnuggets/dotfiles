# Escape potential tarbombs
# http://www.commandlinefu.com/commands/view/6824/escape-potential-tarbombs
etb() {
	l=$(tar tf $1);
	if [ $(echo "$l" | wc -l) -eq $(echo "$l" | grep $(echo "$l" | head -n1) | wc -l) ];
	then tar xf $1;
	else mkdir ${1%.t(ar.gz||ar.bz2||gz||bz||ar)} && tar xvf $1 -C ${1%.t(ar.gz||ar.bz2||gz||bz||ar)};
	fi ;
}

# show newest files
# http://www.commandlinefu.com/commands/view/9015/find-the-most-recently-changed-files-recursively
newest () {find . -type f -printf '%TY-%Tm-%Td %TT %p\n' | grep -v cache | grep -v ".hg" | grep -v ".git" | sort -r | less }

# Rename files in a directory in an edited list fashion
# http://www.commandlinefu.com/commands/view/7818/
function massmove () {
    ls > ls; paste ls ls > ren; vi ren; sed 's/^/mv /' ren|bash; rm ren ls
}

# Put a console clock in top right corner
# http://www.commandlinefu.com/commands/view/7916/
function clock () {
    while sleep 1;
    do
        tput sc
        tput cup 0 $(($(tput cols)-29))
        date
        tput rc
    done &
}

# Query Wikipedia via console over DNS
# http://www.commandlinefu.com/commands/view/2829
wp() {
    dig +short txt ${1}.wp.dg.cx
}

# translate via google language tools (more lightweight than leo)
# http://www.commandlinefu.com/commands/view/5034/
translate() {
    wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'
}

# Function to source files if they exist
function zsh_add_file() {
    [ -f "$ZSH_CONFIG/$1" ] && source "$ZSH_CONFIG/$1"
}

# function to add plugin if it exists or download and add it if it doesn't
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZSH_CONFIG/plugins/$PLUGIN_NAME" ]; then 
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZSH_CONFIG/plugins/$PLUGIN_NAME"
    fi
}

# function to add completions if it exists or download and add if it doesn't
function zsh_add_completion() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ -d "$ZSH_CONFIG/plugins/$PLUGIN_NAME" ]; then 
      # For completions
      completion_file_path=$(ls $ZSH_CONFIG/plugins/$PLUGIN_NAME/_*)
      fpath+="$(dirname "${completion_file_path}")"
      zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
  else
      git clone "https://github.com/$1.git" "$ZSH_CONFIG/plugins/$PLUGIN_NAME"
      fpath+=$(ls $ZSH_CONFIG/plugins/$PLUGIN_NAME/_*)
      [ -f $ZSH_CONFIG/.zccompdump ] && $ZSH_CONFIG/.zccompdump
  fi
	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}
