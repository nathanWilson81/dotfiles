#!/bin/bash
# Install packages
apps=(
    spectacle
    iterm2
    google-chrome
    spotify
    slack
)

brew cask install "${apps[@]}"
