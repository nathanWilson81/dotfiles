#!/bin/bash
# Install packages
apps=(
    spotify
    slack
    font-fira-code
    font-source-code-pro
)

brew tap caskroom/fonts

brew cask install "${apps[@]}"
