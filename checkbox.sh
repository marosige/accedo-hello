#!/bin/bash
# Bash Checkbox
# By @HadiDotSh 

# menu lib: https://github.com/hadidotsh/bash-checkbox 
# coloring: https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124

options=("$@")
max="${#}"
current=0
tput sc

for (( i=0 ; i<max ; i++ ));do
    selected[${i}]=false
done

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

while true;do
    display "$@"
    keyboard $((max-1))
done
current=-1
display "$@"

export options
export selected
export max


