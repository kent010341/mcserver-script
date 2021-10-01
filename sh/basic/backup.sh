#!/bin/bash

if [ $1 == "--help" ]; then
    echo "Usage: ./backup.sh"
    echo "    Proceed a backup process."
    exit 1
fi

# generating the backup folder
if [ ! -d "./backup" ]; then
    echo -e "\033[1;91m[WARNING] The folder 'backup' doesn't exist. \033[0m"
    mkdir backup
    echo -e "\033[1;93m[SUCCESS] Folder 'backup' created. \033[0m"
fi

if [ -d "./world" ]; then
    cp -r ./world ./backup/world$(date +"%Y%m%d")
    echo -e "\033[1;93m[SUCCESS] Backup successed. \033[0m"
else
    echo -e "\033[1;91m[ERROR] The folder 'world' doesn't exist. \033[0m"
    exit 1
fi
