#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master > /dev/null 2>&1

function gitConfig() {
    read name"?What should be your git user name? ";
    read email"?What should be your git user email? ";

    git config --global user.name $name
    git config --global user.email $email

    echo ""
    echo "✅  Git user updated"
    echo ""
}

function copy() {
    echo "🚚  Copying files"

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

    echo ""
    echo "✅  Copy complete"
    echo ""
}

function zsh() {
    read reply"?Want to install ZSH? (y/N) ";
    echo "";

    if [[ $reply =~ ^[Yy]$ ]]; then
        echo "🏗  Installing oh my zsh... "
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1

        echo ""
        echo "✅  Install complete"
        echo "";
    fi;
}

function commitizen() {
    read reply"?Want to install Commitizen? (y/N) ";
    echo "";

    if [[ $reply =~ ^[Yy]$ ]]; then
        echo "🏗  [1/3] Installing commitizen... "
        npm install -g commitizen > /dev/null 2>&1

        echo "🏗  [2/3] Installing conventional-changelog... "
        npm install -g cz-conventional-changelog > /dev/null 2>&1

        echo "🏗  [3/3] Creating .czrc file... "
        echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc

        echo ""
        echo "✅  Install complete"
        echo "";
    fi;
}

function doIt() {
    zsh;
    copy;
    gitConfig;
    commitizen;

    echo "♥️  All steps completed, have fun!"

    unset zsh;
    unset copy;
    unset gitConfig;
    unset commitizen;
}


if [ "$1" "==" "--force" -o "$1" "==" "-f" ]; then
    doIt;
else
    echo ""
    read reply"?This may overwrite existing files in your home directory. Are you sure? (y/N) ";
    echo "";

    if [[ $reply =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;

unset doIt;
