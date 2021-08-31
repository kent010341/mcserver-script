#!/bin/bash

# ==========================================================
# Variables
default_memory=3

# ==========================================================

# function for replacing string at specify line in the file
function replace_file() {
    target_str=$1
    replace_str=$2
    line=$3
    file_dir=$4

    sed ""$line"s/$target_str/$replace_str/g" "$file_dir" > "$file_dir.tmp"
    mv "$file_dir.tmp" "$file_dir"
    chmod +x "$file_dir"

    echo -e "\033[1;93m[SUCCESS] $file_dir rewritten. \033[0m"
}

# ==========================================================
# default_memory
if [ ! "$default_memory" == "default" ]; then
    echo -e "\033[1;96m[INFO] Rewriting default_memory... \033[0m"
    # fast-build.sh
    replace_file "default_memory=.*" "default_memory=$default_memory" 4 "fast-build.sh"

    # basic/start-server.sh
    replace_file "default_memory=.*" "default_memory=$default_memory" 4 "basic/start-server.sh"

    # screen/screen-start-server.sh
    replace_file "default_memory=.*" "default_memory=$default_memory" 4 "screen/screen-start-server.sh"

    # screen/screen-backup.sh
    replace_file "default_memory=.*" "default_memory=$default_memory" 39 "screen/screen-backup.sh"
fi
