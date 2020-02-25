#!/bin/sh

die() {
	echo $@ && exit 1
}

# [ ! -z "$DOT_VERSION" ] || die "nothing to uninstall"

# $1 - backup dir, $2 - source path
mv_object() {
	echo "restore $2 to $HOME/$2"
	local oldpwd=$PWD
	cd $1
	local DIR_PATH=$(dirname $2)
	[ "$DIR_PATH" = "." ] || mkdir -p $HOME/$DIR_PATH
	mv $2 $HOME/$DIR_PATH
	cd $oldpwd
}

# $@ - list of files
unlink_dirs() {
	for dir in $@; do
		if [ -d $HOME/$dir -a -L $HOME/$dir ]; then
			rm $HOME/$dir
		fi
	done
}

# $@ - list of files
unlink_files() {
	for file in $@; do
		if [ -f $HOME/$file -a -L $HOME/$file ]; then
			rm $HOME/$file
		fi
	done
}

# $1 - backup dir
restore_folder() {
	# visible objects
	for obj in $1/*; do
		local path="${obj#$1/}"
		[ "$path" = "*" ] && break
		mv_object $1 $path
	done
	# hidden objects
	for obj in $1/.*; do
		local path="${obj#$1/}"
		[ "$path" = "*" ] && break
		[ "$path" = "." -o "$path" = ".." ] && continue
		mv_object $1 $path
	done
}

# backup dirs
BACKUP_DIRS=
BACKUP_RESTORE_NUM=
BACKUP_DIRS_COUNT=0
if [ -d backup ]; then
	for dir in backup/**; do
		BACKUP_DIRS="$BACKUP_DIRS[$(($BACKUP_DIRS_COUNT+1))]: $dir\n"
		BACKUP_DIRS_COUNT=$(($BACKUP_DIRS_COUNT+1))
	done
fi

if [ $BACKUP_DIRS_COUNT -gt 1 ]; then
	echo "detected backup folder. choice the folder to restore: (0 - for all)\\n"
	echo "$BACKUP_DIRS"
	printf "> "

	while read line; do
		case "$line" in
			[0-$BACKUP_DIRS_COUNT])
				BACKUP_RESTORE_NUM=$line
				break
			;;
			*)
				echo "invalid choice. try again (or ^C for exit)"
				printf "> "
				continue
			;;
		esac
	done
fi

# source install config file
. $PWD/.install_config

unlink_dirs $COPYING_DIRS
unlink_files $COPYING_FILES
unset COPYING_DIRS
unset COPYING_FILES

# restore files and dirs (if exist)
if [ ! -z $BACKUP_RESTORE_NUM ]; then
	if [ $BACKUP_RESTORE_NUM -eq 0 ]; then
		for i in $(seq 1 $BACKUP_DIRS_COUNT); do
			backup_dir=$(echo $BACKUP_DIRS | grep -Po "(?<=\[$i\]: )[^,]*")
			restore_folder $backup_dir
			rm -rf $backup_dir
			unset backup_dir
		done
	elif [ $BACKUP_RESTORE_NUM -gt 0 ]; then
		backup_dir=$(echo $BACKUP_DIRS | grep -Po "(?<=\[$BACKUP_RESTORE_NUM\]: )[^,]*")
		restore_folder $backup_dir
		rm -rf $backup_dir
		unset backup_dir
	fi
fi

unset BACKUP_DIRS_COUNT
unset BACKUP_RESTORE_NUM
unset BACKUP_DIRS

unset DOT_VERSION

# remove default xdg links
if [ ! -z $(which xdg-user-dir) ]; then
	for dir in .downloads .images .desktop; do
		if [ -d $HOME/$dir -a -L $HOME/$dir ]; then
			rm $HOME/$dir
		fi
	done
fi

echo "uninstalled"