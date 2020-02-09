#!/usr/bin/env bash

# path
PLATFORM_PATH=$PWD/.bin
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM_PATH=$PLATFORM_PATH:$HOME/.homebrew/bin:$HOME/Library/Android/sdk/platform-tools
elif [[ "$OSTYPE" == "msys" ]]; then
  PLATFORM_PATH=$ORIGINAL_PATH:/c/Users/$USER/AppData/Roaming/npm:/c/Program\ Files/nodejs
#  PLATFORM_PATH=
#elif [[ "$OSTYPE" == "linux-gnu" ]]; then
#  PLATFORM_PATH=
fi
export PATH=$PATH:$PLATFORM_PATH

# locale set
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8

# java home set
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
#export JAVA_JDK=$JAVA_HOME

# Base16 Shell
#BASE16_SHELL="$HOME/.config/bash/base16-shell"
#[ -n "$PS1" ] && \
#  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#    eval "$("$BASE16_SHELL/profile_helper.sh")"

#export NVM_DIR="$HOME/.nvm"
#  [ -s "/Users/wen1k/opt/nvm/nvm.sh" ] && . "/Users/wen1k/opt/nvm/nvm.sh"  # This loads nvm

# bash prompt
function branch() {
	git branch 2>/dev/null | grep '^*' | colrm 1 2 | awk '{print $0" "}'
}

function shortwd() {
	local num_dirs=3
	local pwd_symbol="..."
	local newPWD="${PWD/#$HOME/~}"
	if [ $(echo -n $newPWD | awk -F '/' '{print NF}') -gt $num_dirs ]; then
		newPWD=$(echo -n $newPWD | awk -F '/' '{print $1 "/.../" $(NF-1) "/" $(NF)}')
	fi
	echo -n $newPWD
}

# aliases
for file in $(ls $PWD/.aliases); do
	source $PWD/.aliases/$file
done

# console color theme
source $PWD/.config/base16-shell/scripts/base16-default-dark.sh

# bash colors foreground text
c_ft_red='\[\033[0;31m\]'
c_ft_green='\[\033[0;32m\]'
c_ft_yellow='\[\033[0;33m\]'
c_ft_blue='\[\033[0;34m\]'
c_ft_magenta='\[\033[0;35m\]'
c_ft_cyan='\[\033[0;36m\]'
c_ft_lightgray='\[\033[0;37m\]'
c_ft_darkgray='\[\033[0;90m\]'

c_ft_lightred='\[\033[0;91m\]'
c_ft_lightgreen='\[\033[0;92m\]'
c_ft_lightyellow='\[\033[0;93m\]'
c_ft_lightblue='\[\033[0;94m\]'
c_ft_lightmagenta='\[\033[0;95m\]'
c_ft_lightcyan='\[\033[0;96m\]'

c_ft_white='\[\033[0;97m\]'
c_ft_default='\[\033[0;39m\]'

c_end='\[\033[m\]'

PS1="${c_ft_darkgray}[${c_end} ${c_ft_cyan}\$(shortwd)${c_end} ${c_ft_magenta}\u${c_end} ${c_ft_green}\$(branch)${c_end}${c_ft_darkgray}]${c_end}"$'\n'"${c_ft_red}; ${c_end}"
