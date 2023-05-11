#!/bin/bash

# menu lib: https://github.com/hadidotsh/bash-checkbox
# coloring: https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124

options=0
max=0
current=0
tput sc

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
    "Slack")              brew install --cask slack ;;
    "1password")          brew install --cask 1password ;;
    "VSCode")             brew install --cask visual-studio-code ;;
    "AndroidStudio")      brew install --cask android-studio ;;
    "Atom")               brew install --cask atom ;;
    "Node")               brew install node ;;
    "ApkTool")            brew install apktool ;;
    "Nvm")                brew install nvm ;;
    "Git")                brew install git ;;
    "CharlesProxy")       brew install --cask charles ;;
    "Fish")               brew install fish ; chsh -s $(which fish) ;;
    "Chrome")             brew install --cask google-chrome ;;
    "Firefox")            brew install --cask firefox ;;
    "Brave")              brew install --cask brave-browser ;;
    "Spotify")            brew install --cask spotify ;;
    "MidnightCommander")  brew install mc ;;
    "NeoFetch")           brew install neofetch ;;
  esac
}

menu() {
  clear;

  #if a value starts with '-' it means its a menu, otherwise a non whitspaced string is fine!
  checkbox  -ACCEDO "Slack" "1password" -IDE "VSCode" "AndroidStudio" "Atom" -DEVTOOLS "Node" "ApkTool" "Nvm" "Git" "CharlesProxy" "Fish" -BROWSERS "Chrome" "Firefox" "Brave" -EXTRAS "Spotify" "MidnightCommander" "NeoFetch"

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
