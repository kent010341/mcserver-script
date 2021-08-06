#!/bin/sh

# generating the backup folder
if [ ! -d "./backup" ]; then
    echo "\033[31m[WARNING] The folder 'backup' doesn't exist. \033[0m"
    mkdir backup
    echo "\033[33m[SUCCESS] Folder 'backup' created. \033[0m"
fi

if [ -d "./world" ]; then
    cp -r ./world ./backup/world$(date +"%Y%m%d")
    echo "\033[33m[SUCCESS] Backup successed. \033[0m"
else
    echo "\033[31m[ERROR] The folder 'world' doesn't exist. \033[0m"
    exit 1
fi
