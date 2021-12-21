#!/bin/bash

# default value
default_memory=2 # GB
default_filename=server.jar

#======================================================
# parameter parsing
while (($#)); do
    case $1 in
        "--memory" | "-m")
            shift
            default_memory=$1
            shift
        ;;
        "--filename" | "-f")
            shift
            default_filename=$1
            shift
        ;;
        "--path" | "-p")
            shift
            cd $1
            shift
        ;;
        "--help" | "-h")
            echo "Usage: ./screen-start-server.sh [options...]"
            echo "    --memory <memory>, -m <memory>"
            echo "        RAM used for the server (in GB)"
            echo "    --filename <file name>, -f <file name>"
            echo "        The file name of server.jar"
            echo "    --path <path>, -p <path>"
            echo "        The path of server.jar"
            exit 1
        ;;
        *)
            echo "unknown argument '$1'"
            echo "Use --help (or -h) to get the usage information."
            exit 1
        ;;
    esac
done

#======================================================
# check screen installed
screen -version

# if the command above execute failed, install screen
if [ ! $? -eq 1 ] && [ ! $? -eq 0 ]; then
    echo -e "\033[1;91m[WARNING] screen isn't installed. Start installing... \033[0m"
    sudo apt-get install screen -y 
    echo -e "\033[1;93m[SUCCESS] screen installed. \033[0m"
fi

#======================================================
# preparing variables & start server

# defaultly using 2GB memory for server
gb=$default_memory
mb=$(expr $gb \* 1024)M

# defaultly using server.jar as file name
filename=$default_filename

# test screen session "mc" exist
screen -r mc -X stuff "echo test\n"

# if the command above execute failed, create a detached screen
if [ ! $? -eq 0 ]; then
    screen -dmS mc
else
    screen -r mc -X stuff "cd $(pwd)\n"
fi

# start server with screen
screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar $filename nogui\n"

echo -e "\033[1;93m[SUCCESS] Server has already started at a detached screen 'mc'. \033[0m"
echo -e "\033[1;93m[SUCCESS] Use 'screen -r mc' to get into the screen. (Use Ctrl + A + D to leave) \033[0m"
