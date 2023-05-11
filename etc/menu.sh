#!/usr/bin/env bash

clear;

#if a value starts with '-' it means its a menu, otherwise a non whitspaced string is fine!
source checkbox.sh "homebrew-(package_manager)" "slack-(messages)" 1password -GERGO vscode androidStudio apktool npm charles nordlayer

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

## now loop through the above array
for i in "${INSTALLABLES[@]}"
do
   echo "$i"
   # or do whatever with individual element of the array
done
