#!/bin/bash

# defaultly using 2GB memory for server
# defaultly using server.jar as file name
default_memory=2
default_filename=server.jar

# parameter parsing
while (($#)); do
    case $1 in
        "--memory")
            shift
            default_memory=$1
            shift
        ;;
        "--filename")
            shift
            default_filename=$1
            shift
        ;;
        "--help")
            echo "Usage: ./start-server.sh [options...]"
            echo "    --memeory <memory>    RAM used for the server (in GB)"
            echo "    --filename <file name>    The file name of server.jar"
            exit 1
        ;;
        *)
            echo "unknown argument '$1'"
            echo "Use --help to get the usage information."
            exit 1
        ;;
    esac
done

gb=$default_memory

mb=$(expr $gb \* 1024)M

filename=$default_filename

echo -e "\033[1;96m[INFO] Starting server with memory $gb GB... \033[0m"
sleep 1s

# start server
java -Xmx$mb -Xms$mb -jar $filename nogui
