#!/bin/bash

# test screen session "mc" exist
screen -r mc -X stuff "/say Server will be closed in 10 seconds. Restart after the backup process completed (usually less than 1 minute).\n"

# if the command above execute failed, send error message and quit
if [ ! $? -eq 0 ]; then
    echo -e "\033[31m[ERROR] screen session 'mc' doesn't exist. \033[0m"
    exit 1
fi

echo -e "\033[36m[INFO] Warning players in game that server will be closed in 10 seconds... \033[0m"
echo -e "\033[36m[INFO] Press Ctrl + C to interrupt the process. \033[0m"
sleep 10s

# stop server
screen -r mc -X stuff '/stop\n'
echo -e "\033[36m[INFO] Server stopped. \033[0m"

# generating the backup folder
if [ ! -d "./backup" ]; then
    echo -e "\033[31m[WARNING] The folder 'backup' doesn't exist. \033[0m"
    mkdir backup
    echo -e "\033[33m[SUCCESS] Folder 'backup' created. \033[0m"
fi

if [ -d "./world" ]; then
    cp -r ./world ./backup/world$(date +"%Y%m%d")
    echo -e "\033[33m[SUCCESS] Backup successed. \033[0m"
else
    echo -e "\033[31m[ERROR] The 'world' folder doesn't exist. \033[0m"
    exit 1
fi

#======================================================
# restart server (same as screen-start-server.sh)

# default value
default_memory=2 # GB
default_filename=server.jar

#======================================================
# preparing variables & start server

# defaultly using 2GB memory for server
gb=${1:-$default_memory}
mb=$(expr $gb \* 1024)M

# defaultly using server.jar as file name
filename=${2:-$default_filename}

# start server with screen
screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar $filename nogui\n"

echo -e "\033[33mServer has already started at a detached screen 'mc'. \033[0m"
echo -e "\033[33mUse 'screen -r mc' to get into the screen. (Use Ctrl + A + D to leave) \033[0m"
