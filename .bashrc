# ~/.bashrc

# if not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# platform specific path
PLATFORM_PATH=$HOME/.bin
if [[ "$OSTYPE" == "darwin"* ]]; then
	PLATFORM_PATH=$PLATFORM_PATH:$HOME/.homebrew/bin:$HOME/Library/Android/sdk/platform-tools
elif [[ "$OSTYPE" == "msys" ]]; then
	PLATFORM_PATH=$ORIGINAL_PATH
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	PLATFORM_PATH=$HOME/.bin/linux
fi
export PATH=$PATH:$PLATFORM_PATH

# for git branch prompt
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
if [ -d $HOME/.aliases ]; then
	for file in $HOME/.aliases/*; do
		source $file
	done
fi

# console color theme
if [ -z "$KONSOLE_PROFILE_NAME" ]; then
	source $HOME/.config/base16-shell/scripts/base16-default-dark.sh
fi

# export dotfiles version
export DOT_VERSION=$(cat $HOME/.dot_version)

# human readable bash colors
c_ft_black='\[\033[0;30m\]'
c_ft_red='\[\033[0;31m\]'
c_ft_green='\[\033[0;32m\]'
c_ft_yellow='\[\033[0;33m\]'
c_ft_blue='\[\033[0;34m\]'
c_ft_magenta='\[\033[0;35m\]'
c_ft_cyan='\[\033[0;36m\]'
c_ft_white='\[\033[0;37m\]'

c_ft_lightblack='\[\033[0;90m\]'
c_ft_lightred='\[\033[0;91m\]'
c_ft_lightgreen='\[\033[0;92m\]'
c_ft_lightyellow='\[\033[0;93m\]'
c_ft_lightblue='\[\033[0;94m\]'
c_ft_lightmagenta='\[\033[0;95m\]'
c_ft_lightcyan='\[\033[0;96m\]'
c_ft_lightwhite='\[\033[0;97m\]'

c_ft_default='\[\033[0;39m\]'
c_end='\[\033[m\]'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

PS1="${c_ft_lightblack}[${c_end} ${c_ft_cyan}\$(shortwd)${c_end} ${c_ft_magenta}\u${c_end} ${c_ft_green}\$(branch)${c_end}${c_ft_lightblack}]${c_end}"$'\n'"${c_ft_red}; ${c_end}"