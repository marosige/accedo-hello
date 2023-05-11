#!/bin/bash

# menu lib: https://github.com/hadidotsh/bash-checkbox
# coloring: https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

options=0
max=0
current=0
tput sc

sayhello() {
  printf "                        _             _          _ _       \n"
  printf "                       | |        ${RED}_${NC}  | |        | | |      \n"
  printf "  __ _  ___ ___ ___  __| | ___   ${RED}(#)${NC} | |__   ___| | | ___  \n"
  printf " / _  |/ __/ __/ _ \/ _  |/ _ \      |  _ \ / _ \ | |/ _ \ \n"
  printf "| (_| | (_| (_|  __/ (_| | (_) |  ${BLUE}_${NC}  | | | |  __/ | | (_) |\n"
  printf " \__,_|\___\___\___|\__,_|\___/  ${BLUE}(#)${NC} |_| |_|\___|_|_|\___/ \n"
  echo "-----------------------------------------------------------"
  echo ""
}

function keyboard(){

    IFS= read -r -sn1 t
    if [[ $t == A ]]; then
        [[ "$current" == "0" ]] || current=$((current - 1))

    elif [[ $t == B ]]; then
        [[ "$current" == "$1" ]] || current=$((current + 1))

    elif [[ $t == " " ]];then
        [[ "${selected[${current}]}" == false ]] && selected[${current}]=true || selected[${current}]=false
    elif [[ $t == "" ]];then
        break
    fi
}

function display(){
    tput rc
    for (( i=0 ; i<max ; i++ ));do
        if [[ ${current} == "${i}" && ${selected[${i}]} == true ]];then
            if [[ "${options[$i]}" = -* ]]
                then
	            printf "\e[0m\e[1;77m%s\e[0m\n" "${options[$i]}"
            else
                printf "\e[0;90m[\e[0;91m*\e[0;90m] \e[0m\e[0;91m%s\e[0m\n" "${options[$i]}"
            fi

        elif [[ ${current} == "${i}" && ${selected[${i}]} == false ]];then
            if [[ "${options[$i]}" = -* ]]
                then
	            printf "\e[0m\e[1;77m%s\e[0m\n" "${options[$i]}"
            else
                printf "\e[0;90m[ ] \e[0m\e[0;91m%s\e[0m\n" "${options[$i]}"
            fi

        elif [[ ${selected[${i}]} == true ]];then
            if [[ "${options[$i]}" = -* ]]
                then
	            printf "\e[0m\e[1;77m%s\e[0m\n" "${options[$i]}"
            else
                printf "\e[0;90m[\e[0;91m*\e[0;90m] \e[0m\e[1;77m%s\e[0m\n" "${options[$i]}"
            fi

        elif [[ ${selected[${i}]} == false ]];then
            if [[ "${options[$i]}" = -* ]]
                then
	            printf "\e[0m\e[1;77m%s\e[0m\n" "${options[$i]}"
            else
                printf "\e[0;90m[ ] \e[0m\e[1;77m%s\e[0m\n" "${options[$i]}"
            fi
        fi
    done
}

checkbox() {
  options=("$@")
  max="${#}"
  current=0
  tput sc

  for (( i=0 ; i<max ; i++ ));do
      selected[${i}]=false
  done

  while true;do
      display "$@"
      keyboard $((max-1))
  done
  current=-1
  display "$@"

  export options
  export selected
  export max
}

install_homebrew() {
  # Install homebrew if it was not installed previously
  which -s brew
  if [[ $? != 0 ]] ; then
      # Install Homebrew
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

brew_install() {
  case "$1" in
    # Accedo
    "Slack")              brew install --cask slack ;;
    "1password")          brew install --cask 1password ;;
    # IDE / Text Editor
    "AndroidStudio")      brew install --cask android-studio ;;
    "VSCode")             brew install --cask visual-studio-code ;;
    "Atom")               brew install --cask atom ;;
    "Webstorm")           brew install --cask webstorm ;;
    "IntelliJIDEA")       brew install --cask intellij-idea ;;
    "SublimeText")        brew install --cask sublime-text ;;
    "MicrosoftOffice")    brew install --cask microsoft-office ;;
    # Development Tools
    "AndroidSDK")         brew install --cask android-sdk ;;
    "ApkTool")            brew install apktool ;;
    "OpenJDK")            brew install --cask microsoft-openjdk ;;
    "Node")               brew install node ;;
    "Nvm")                brew install nvm ;;
    "Docker")             brew install docker ;;
    "Colima")             brew install colima ;;
    "Fish")               brew install fish ; chsh -s $(which fish) ;;
    # Networking
    "CharlesProxy")       brew install --cask charles ;;
    "Wireshark")          brew install wireshark ;;
    "NordLayer")          brew install --cask nordlayer ;;
    "Tunnelblick")        brew install --cask tunnelblick ;;
    # Version Control
    "Git")                brew install git ;;
    "Sourcetree")         brew install --cask sourcetree ;;
    "GitKraken")          brew install --cask gitkraken ;;
    "GitHubDesktop")      brew install --cask github ;;
    # Web Browsers
    "Chrome")             brew install --cask google-chrome ;;
    "Firefox")            brew install --cask firefox ;;
    "Brave")              brew install --cask brave-browser ;;
    "Opera")              brew install --cask opera ;;
    "OperaGX")            brew install --cask opera-gx ;;
    # File Management
    "MidnightCommander")  brew install mc ;;
    "TheUnarchiver")      brew install --cask the-unarchiver ;;
    "7zip")               brew install sevenzip ;;
    "AndroidFileTransfer")brew install --cask android-file-transfer ;;
    # Communication
    "Zoom")               brew install --cask zoom ;;
    "Skype")              brew install --cask skype ;;
    "Webex")              brew install --cask webex ;;
    # Extras
    "Spotify")            brew install --cask spotify ;;
    "VLC")                brew install --cask vlc ;;
    "AppCleaner")         brew install --cask appcleaner ;;
    "NeoFetch")           brew install neofetch ;;
    # Debloat
    "ClearDock")          refresh_dock ;;
  esac
}

refresh_dock() {
    clear_dock() {
        defaults delete com.apple.dock persistent-apps
    }

    add_dock_shortcuts() {
        while IFS= read -r line
        do
            defaults write com.apple.dock persistent-apps -array-add "<dict>
                <key>tile-data</key>
                <dict>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>$line</string>
                        <key>_CFURLStringType</key>
                        <integer>0</integer>
                    </dict>
                </dict>
            </dict>"
        done
    }

    clear_dock
    # echo "/Applications/Firefox.app\n/System/Applications/System Settings.app" | add_dock_shortcuts

    killall Dock
}

menu() {
  clear;
  sayhello

  #if a value starts with '-' it means its a menu, otherwise a non whitspaced string is fine!
  checkbox  -ACCEDO "Slack" "1password" -TEXT_EDITOR "AndroidStudio" "VSCode" "Atom" "Webstorm" "IntelliJIDEA" "SublimeText" "MicrosoftOffice" -DEVTOOLS "AndroidSDK" "ApkTool" "OpenJDK" "Node" "Nvm" "Docker" "Colima" "Fish" -NETWORKING "CharlesProxy" "Wireshark" "NordLayer" "Tunnelblick" -VERSION_CONTROL "Git" "Sourcetree" "GitKraken" "GitHubDesktop" -BROWSERS "Chrome" "Firefox" "Brave" "Opera" "OperaGX" -FILE_MANAGEMENT "MidnightCommander" "TheUnarchiver" "7zip" "AndroidFileTransfer" -COMMUNICATION "Zoom" "Skype" "Webex" -EXTRAS "Spotify" "VLC" "AppCleaner" "NeoFetch" -DEBLOAT "ClearDock"

  clear;

  declare -a INSTALLABLES=()
  for (( i=0 ; i < max ; i++ ));do
      if [[ "${selected[$i]}" == true ]]
      then
          #filter out the titles
          if ! [[ "${options[$i]}" = -* ]]
              then
                  INSTALLABLES+=(${options[$i]})
              fi
      fi
  done

  install_homebrew

  ## now loop through the above array
  for i in "${INSTALLABLES[@]}"
  do
     brew_install "$i"
  done
}

menu
