#!/bin/bash

# defaultly using 2GB memory for server
default_memory=2
gb=${1:-$default_memory}

mb=$(expr $gb \* 1024)M

# defaultly using server.jar as file name
default_filename=server.jar
filename=${2:-$default_filename}

echo -e "\033[1;96m[INFO] Starting server with memory $gb GB... \033[0m"
sleep 1s

# start server
java -Xmx$mb -Xms$mb -jar $filename nogui
