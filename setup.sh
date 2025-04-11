#!/usr/bin/env zsh

echo "Setting up..."


# Install xcode cli
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
  test -d "${xpath}" && test -x "${xpath}" ; then
  echo "Skipping XCode CLI install already installed"
else
  echo "Installing XCode CLI..."
  xcode-select --install
fi

echo "Installing oh my zsh... "
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else 
  echo "Skipping homebrew, already installed"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

PACKAGES=(
  1password
  cmake
  fzf
  git
  git-trim
  kitty
  neovim
  readline
  ripgrep
  starship
  stow
  tree-sitter
)

echo "Installing packages..."
brew install ${PACKAGES[@]} -q


echo "Configuring OS..."

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "Stowwing..."
stow -t ~ stow

echo "All steps completed, have fun!"
