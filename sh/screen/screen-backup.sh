#!/bin/sh

# test screen session "mc" exist
screen -r mc -X stuff "/say Server will be closed in 10 seconds. Restart after the backup process completed (usually less than 1 minute).\n"

# if the command above execute failed, send error message and quit
if [ ! $? -eq 0 ]; then
    echo "\033[31m[ERROR] screen session 'mc' doesn't exist. \033[0m"
    exit 1
fi

sleep 10s

# stop server
screen -r mc -X stuff '/stop\n'

# generating the backup folder
if [ ! -d "./backup" ]; then
    echo "The 'backup' folder doesn't exist."
    mkdir backup
    echo "'backup' folder created."
fi

if [ -d "./world" ]; then
    cp -r ./world ./backup/world$(date +"%Y%m%d")
    echo "\033[33mBackup successed. \033[0m"
else
    echo "\033[31m[ERROR] The 'world' folder doesn't exist. \033[0m"
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

echo "\033[33mServer has already started at a detached screen 'mc'. \033[0m"
echo "\033[33mUse 'screen -r mc' to get into the screen. (Use Ctrl + A + D to leave) \033[0m"
