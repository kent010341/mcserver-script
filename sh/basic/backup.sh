#!/bin/sh

# generating the backup folder
if [ ! -d "./backup" ]; then
    echo "The 'backup' folder doesn't exist."
    mkdir backup
    ecdir "'backup' folder created."
fi

if [ -d "./world" ]; then
    cp -r ./world ./backup/world$(date +"%Y%m%d")
    echo "backup successed."
else
    echo "The 'world' folder doesn't exist."
    exit 1
fi
