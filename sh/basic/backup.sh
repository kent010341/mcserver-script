#!/bin/sh

# generating the backup folder
if [ ! -d "./backup" ]; then
    echo -e "\033[31m[WARNING] The folder 'backup' doesn't exist. \033[0m"
    mkdir backup
    ecdir "Folder 'backup' created."
fi

if [ -d "./world" ]; then
    cp -r ./world ./backup/world$(date +"%Y%m%d")
    echo -e "\033[33mBackup successed. \033[0m"
else
    echo -e "\033[31m[ERROR] The folder 'world' doesn't exist. \033[0m"
    exit 1
fi
