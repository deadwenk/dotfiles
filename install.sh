#!/bin/sh

die() {
	echo $@ && exit 1
}

[ -z "$DOT_VERSION" ] || die "already installed"

BACKUP_DIR=
create_backup_dir() {
	BACKUP_DIR="backup/$(date +"%Y_%m_%d-%H_%M_%S")"
	mkdir -p $BACKUP_DIR
}

# $1 - move to path
backup_object() {
	[ -d backup -a ! -z "$BACKUP_DIR" ] || create_backup_dir
	echo "backup $1 to $BACKUP_DIR"
	local DIR_PATH=$(dirname $1)
	[ "$DIR_PATH" = "." ] || mkdir -p ./$BACKUP_DIR/$DIR_PATH
	mv $HOME/$1 ./$BACKUP_DIR/$DIR_PATH
}

# $1 - link to path
link_object() {
	local DIR_PATH=$(dirname $1)
	[ "$DIR_PATH" = "." ] || mkdir -p $HOME/$DIR_PATH
	ln -s $PWD/$1 $HOME/$DIR_PATH
}

# $@ - list of files
backup_dirs() {
	for dir in $@; do
		if [ -d $HOME/$dir ]; then
			if [ -L $HOME/$dir ]; then
				rm $HOME/$dir
			else
				backup_object $dir
			fi
		fi
	done
}

# $@ - list of files
backup_files() {
	for file in $@; do
		if [ -f $HOME/$file ]; then
			if [ -L $HOME/$file ]; then
				rm $HOME/$file
			else
				backup_object $file
			fi
		fi
	done
}

# $@ - list of dirs
link_dirs() {
	for dir in $@; do
		if [ ! -d $HOME/$dir ]; then
			link_object $dir
		else
			# TODO: add user answer for replace, y/n
			echo "warning. directory $HOME/$dir already exist. nothing to do"
		fi
	done
}

# $@ - list of files
link_files() {
	for file in $@; do
		if [ ! -f $HOME/$file ]; then
			link_object $file
		else
			# TODO: add user answer for replace, y/n
			echo "warning. file $HOME/$file already exist. nothing to do"
		fi
	done
}

# source install config file
. $PWD/.install_config

[ ! -z $(which git) ] || die "cannot find git executable"
git submodule update --init --recursive
[ ! -z $0 ] || die "cannot update submodules"

backup_dirs $COPYING_DIRS
backup_files $COPYING_FILES
link_dirs $COPYING_DIRS
link_files $COPYING_FILES

unset BACKUP_DIR
unset COPYING_DIRS
unset COPYING_FILES

# configure default xdg links
if [ ! -z $(which xdg-user-dir) ]; then
	ln -s "$(xdg-user-dir DOWNLOAD)" $HOME/.downloads
	ln -s "$(xdg-user-dir PICTURES)" $HOME/.images
	ln -s "$(xdg-user-dir DESKTOP)" $HOME/.desktop
fi

echo "installed"