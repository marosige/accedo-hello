#!/bin/bash

uninstall=false

brewit() {
  if [ "$#" -eq 0 ]; then
    exit 1
  elif [ "$uninstall" = true ] ; then
    brew remove $@
  else
    brew install $@
  fi
}

# If first param is uninstall it will uninstall homebrew apps
if [ $1 = "uninstall" ]; then
  uninstall=true
fi

# Install homebrew if it was not installed previously
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brewit --cask google-chrome

# brew cask install slack

# brew cask install 1password

# brew cask install android-studio

brewit --cask atom

brewit neofetch

# brew cask install spotify

brewit --cask tiles

# Uninstall homebrew
if [ "$uninstall" = true ] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
else
