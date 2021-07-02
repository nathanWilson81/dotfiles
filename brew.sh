#!/bin/bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Note that I install nvm (https://github.com/creationix/nvm) instead
# of installing Node directly. This gives me more explicit control over
# which version I'm using.

apps=(
    Schniz/tap/fnm
    bash-completion2
    fd
    fortune
    fzf
    git
    git-extras
    luajit --HEAD
    neovim --HEAD
    nvm
    python
    python3
    ripgrep
    ruby
    tmux
    tmuxinator
    watchman
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup
