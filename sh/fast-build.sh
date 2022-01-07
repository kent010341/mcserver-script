#!/bin/bash

# Global variables
default_memory=2 #GB
is_ecb=false
is_d_set=false
is_seed_set=false
is_version_set=false

version_file_url="https://raw.githubusercontent.com/kent010341/mcserver-script/master/sh/source/version-hash.txt"

while (($#)); do
    case $1 in
        "--memory" | "-m")
            shift
            default_memory=$1
            shift
        ;;
        "--version" | "-v")
            shift
            is_version_set=true
            version=$1
            shift
        ;;
        "--path" | "-p")
            shift
            cd $1
            shift
        ;;
        "--enable-command-block" | "-ecb")
            is_ecb=true
            shift
        ;;
        "--difficulty" | "-d")
            shift
            if [ $1 != "hard" ] && [ $1 != "normal" ] && 
                [ $1 != "easy" ] && [ $1 != "peace" ]; then
                echo -e "\033[1;91m[ERROR] Unacceptable difficulty '$1'. It should be 'hard', 'normal', 'easy' or 'peace'. \033[0m"
                exit 1
            fi
            is_d_set=true
            difficulty=$1
            shift
        ;;
        "--seed" | "-s")
            shift
            is_seed_set=true
            seed=$1
            shift
        ;;
        "--help" | "-h")
            echo "Usage: [sudo] ./fast-build.sh [options...]"
            echo "    --memory <memory>, -m <memory>"    
            echo "        RAM used for the server (in GB)"
            echo "    --version <version>, -v <version>"    
            echo "        Minecraft server version"
            echo "    --path <path>, -p <path>"
            echo "        The path of server.jar"
            echo "    --enable-command-block, -ecb"    
            echo "        Enable command block in server.properties"
            echo "    --difficulty <difficulty>, -d <difficulty>"    
            echo "        Set difficulty in server.properties, available value: hard, normal, easy, peace"
            echo "    --seed <seed>, -s <seed>"    
            echo "        Set seed in server.properties"
            exit 1
        ;;
        *)
            echo "unknown argument '$1'"
            echo "Use --help (or -h) to get the usage information."
            exit 1
        ;;
    esac
done

function replace_file() {
    target_str=$1
    replace_str=$2
    file_dir=$3

    sed "s/$target_str/$replace_str/g" "$file_dir" > "$file_dir.tmp"
    mv "$file_dir.tmp" "$file_dir"
}

# ==========================================================
# check Java and screen

if [ $EUID -ne 0 ]; then
    echo -e "\033[1;91m[WARNING] This script is recommended running with sudo. \033[0m"
    sleep 2s
fi

# check Java version
echo -e "\033[1;96m[INFO] Checking Java... \033[0m"
java -version

# if the command above execute failed, download the latest version of JDK
if [ $? -eq 0 ]; then
    echo -e "\033[1;96m[INFO] Java is installed. \033[0m"
else
    # install JRE of Java 17 (for 1.18)
    echo -e "\033[1;96m[INFO] Java isn't installed. Start installing... \033[0m"
    sudo apt-get install openjdk-17-jre -y
    if [ $? -eq 0 ]; then
        echo -e "\033[1;93m[SUCCESS] Java installed successfully. \033[0m"
    else
        echo -e "\033[1;91m[ERROR] Java installed failed. \033[0m"
        exit 1
    fi
fi

# check screen installed
echo -e "\033[1;96m[INFO] Checking screen... \033[0m"
screen -version

# if the command above execute failed, install screen
if [ $? -eq 0 ] || [ $? -eq 1 ]; then
    echo -e "\033[1;96m[INFO] screen is installed. \033[0m"
else
    echo -e "\033[1;96m[INFO] screen isn't installed. Start installing... \033[0m"
    sudo apt-get install screen -y 
    if [ $? -eq 0 ]; then
        echo -e "\033[1;93m[SUCCESS] screen installed successfully. \033[0m"
    else
        echo -e "\033[1;91m[ERROR] screen installed failed. \033[0m"
        exit 1
    fi
fi   

# ==========================================================
# get server file
if [ -f "server.jar" ]; then
    echo -e "\033[1;96m[INFO] server.jar already exists. \033[0m"
else
    echo -e "\033[1;96m[INFO] Prepare to download minecraft server (version $version) \033[0m"

    response=$(curl --silent $version_file_url)

    if ! $is_version_set; then
        version=$(echo "$response" | grep "latest=" | cut -d">" -f 2)
    fi
    version_hash_key=$(echo "$response" | grep "$version=" | cut -d">" -f 2)

    if [ "$version_hash_key" == "" ]; then
        echo -e "\033[1;91m[ERROR] Unsupported version. \033[0m"
        exit 1
    fi

    url="https://launcher.mojang.com/v1/objects/$version_hash_key/server.jar"

    # download
    wget -O ./server.jar $url
    if [ $? -eq 0 ]; then
        echo -e "\033[1;93m[SUCCESS] server.jar already downloaded. \033[0m"
    else
        echo -e "\033[1;91m[WARNING] Download process using wget failed. Use curl instead. \033[0m"
        curl $url --silent -o ./server.jar
        if [ $? -eq 0 ]; then
            echo -e "\033[1;93m[SUCCESS] server.jar already downloaded. \033[0m"
        else
            echo -e "\033[1;91m[ERROR] Download server.jar failed. \033[0m"
            exit 1
        fi
    fi
fi

# ==========================================================
# test screen session "mc" exist
screen -r mc -X stuff "echo test\n"

# if the command above execute failed, create a detached screen
if [ ! $? -eq 0 ]; then
    screen -dmS mc
else
    screen -r mc -X stuff "cd $(pwd)\n"
fi

# ==========================================================
# run server.jar for initialize files
gb=$default_memory
mb=$(expr $gb \* 1024)M

echo -e "\033[1;96m[INFO] Starting server with memory $gb GB... \033[0m"
sleep 1s

# start server
screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar ./server.jar nogui\n"

echo -e "\033[1;93m[SUCCESS] Server has already initialized at a detached screen 'mc'. \033[0m"

# ==========================================================
# Wait for the initializing process finished 
echo -e "\033[1;96m[INFO] Wait until the initializing process finished... \033[0m"
sleep 3s
while [ ! -f "eula.txt" ] | [ ! -f "server.properties" ] | [ ! -d "libraries" ] | [ ! -d "logs" ] | [ ! -d "versions" ]; do
    sleep 1s
done
sleep 3s

echo -e "\033[1;96m[INFO] The initializing process is finished. \033[0m"

# edit eula.txt
replace_file "eula=.*" "eula=true" eula.txt

# edit server.properties
if is_ecb ; then
    replace_file "enable-command-block=.*" "enable-command-block=true" server.properties
fi

if is_d_set; then
    replace_file "difficulty=.*" "difficulty=$difficulty" server.properties
fi

if is_seed_set ; then
    echo "level-seed=$seed" >> server.properties
fi

# start server
screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar ./server.jar nogui\n"

echo -e "\033[1;93m[SUCCESS] Server has already started at a detached screen 'mc'. \033[0m"
echo -e "\033[1;93m[SUCCESS] Use 'screen -r mc' to get into the screen. (Use Ctrl + A + D to leave) \033[0m"
