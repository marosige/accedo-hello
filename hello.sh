
install() {
  # Install homebrew if it was not installed previously
  which -s brew
  if [[ $? != 0 ]] ; then
      # Install Homebrew
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Iterate
  for var in "$@"
  do
      # echo "$var"
      brew_install "$var"
  done
}

brew_install() {
  case "$1" in
    "slack")          brew install --cask slack ;;
    "1password")      brew install --cask 1password ;;
    "android-studio") brew install --cask android-studio ;;
    "vscode")         brew install --cask visual-studio-code ;;
    "atom")           brew install --cask atom ;;
    "node")           brew install node ;;
    "apktool")        brew install apktool ;;
    "node")           brew install node ;;
    "nvp")            brew install nvm ;;
    "git")            brew install git ;;
    "charles")        brew install --cask charles ;;
    "fish")           brew install fish ; chsh -s $(which fish) ;;
    "chrome")         brew install --cask google-chrome ;;
    "firefox")        brew install --cask firefox ;;
    "brave")          brew install --cask brave-browser ;;
    "spotify")        brew install --cask spotify ;;
    "mc")             brew install mc ;;
    "neofetch")       brew install neofetch ;;
    "spotify")        brew install --cask spotify ;;
  esac
}

install
