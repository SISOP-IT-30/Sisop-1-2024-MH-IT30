#!/bin/bash
path="/home/PuroFuro/gingseng/genshin_character"

for folder in $path/*; do
  for file in $folder/*.jpg; do

    fix=$(echo "${file%.*}")
    name=$(echo "${file##*/}")
    steghide extract -sf "$file" -xf "$fix".txt -p "" -q
    string=$(cat "$fix.txt")
    time=$(date '+%d/%m/%y %H:%M:%S')   

    if [[ $string == *aHR0cHM* ]]
    then
        found=$(echo $string | base64 -d )
        echo -e "\n$time: Found the secret file at $fix\nThe URL is $found"
        echo "$time [FOUND] $fix" >> image.log
        
        wget --content-disposition $found
        echo "$found" >> "/home/PuroFuro/gingseng/$name.txt"
        rm -rf "$fix.txt"
        exit 0
    else
        echo "$time Not this one.."
        echo "$time [NOT FOUND] $fix" >> image.log
        rm -rf "$fix.txt"
    fi

    sleep 1
    done 

done