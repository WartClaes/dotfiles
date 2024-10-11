#!/usr/bin/env zsh

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

function brewInstall() {
  read reply"?Want to install brew packages? (y/N) ";
  echo "";

  if [[ $reply =~ ^[Yy]$ ]]; then

    if test ! $(which brew); then
      echo "🏗  [1/3] Installing homebrew... "
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else 
      echo "🏗  [1/3] Skipping homebrew, already installed... "
    fi

    echo "🏗  [2/3] updating homebrew... "
    brew update

    echo "🏗  [3/3] Installing packages... "
    PACKAGES=(
      cmake
      fzf
      git
      git-trim
      kitty
      neovim
      readline
      ripgrep
      starship
      tree-sitter
    )
    brew install ${PACKAGES[@]} -q

    echo ""
    echo "✅  Install complete"
    echo "";
  fi;
}

function doIt() {
  # Install xcode cli
  if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
    test -d "${xpath}" && test -x "${xpath}" ; then
      echo "Skipping XCode CLI install already installed"
    else
      echo "Installing XCode CLI"
      xcode-select --install
  fi

  zsh;
  copy;
  gitConfig;
  commitizen;
  brewInstall;

  echo "♥️  All steps completed, have fun!"

  unset zsh;
  unset copy;
  unset gitConfig;
  unset commitizen;
}


if [ "$1" "==" "--force" -o "$1" "==" "-f" ]; then
  echo "Force it"

  doIt;
elif [ "$1" "==" "--brew" -o "$1" "==" "-b" ]; then
  echo "Brew it"
  brewInstall
else
  echo ""
  read reply"?This may overwrite existing files in your home directory. Are you sure? (y/N) ";
  echo "";

  if [[ $reply =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;

unset doIt;
