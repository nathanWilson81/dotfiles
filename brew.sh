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

brew tap homebrew/versions
brew tap homebrew/dupes
brew tap Goles/battery

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Note that I install nvm (https://github.com/creationix/nvm) instead
# of installing Node directly. This gives me more explicit control over
# which version I'm using.

apps=(
    nvm
    bash-completion2
    fortune
    git
    git-extras
    homebrew/completions/brew-cask-completion
    homebrew/dupes/grep
    homebrew/dupes/openssh
    python
    python3
    ripgrep
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup
