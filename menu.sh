#!/usr/bin/env bash

clear;

source checkbox.sh "homebrew-(package_manager)" "slack-(messages)" 1password vscode androidStudio apktool npm charles nordlayer

clear;

declare -a INSTALLABLES=()
for (( i=0 ; i < max ; i++ ));do
    if [[ "${selected[$i]}" == true ]]
    then
        #echo "${options[$i]}" "${selected[$i]}"
        INSTALLABLES+=(${options[$i]})
    fi
done

## now loop through the above array
for i in "${INSTALLABLES[@]}"
do
   echo "$i"
   # or do whatever with individual element of the array
done
