#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;

	if [ -n "$ZSH_VERSION" ]; then
	   source ~/.zshrc;
	elif [ -n "$BASH_VERSION" ]; then
	   source ~/.bash_profile;
	else
	   echo 'unknown shell'
	fi
}

if [ "$1" "==" "--force" -o "$1" "==" "-f" ]; then
	doIt;
else
	read reply"?This may overwrite existing files in your home directory. Are you sure? (y/n) ";
	echo "";
	if [[ $reply =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
