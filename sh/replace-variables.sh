#!/bin/bash

# ==========================================================
# Variables
default_memory="default"
default_filename="default"
default_version="default"

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

    if [ ! "file_dir" == "replace-variables.sh" ]; then
        echo -e "\033[1;93m[SUCCESS] $file_dir rewritten. \033[0m"
    fi
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

    # restore variable to default
    replace_file "default_memory=.*" "default_memory=\"default\"" 5 "replace-variables.sh"
fi

# default_filename
if [ ! "$default_filename" == "default" ]; then
    echo -e "\033[1;96m[INFO] Rewriting default_filename... \033[0m"
    # fast-build.sh
    replace_file "default_filename=.*" "default_filename=$default_filename" 5 "fast-build.sh"

    # basic/start-server.sh
    replace_file "default_filename=.*" "default_filename=$default_filename" 10 "basic/start-server.sh"

    # screen/screen-start-server.sh
    replace_file "default_filename=.*" "default_filename=$default_filename" 5 "screen/screen-start-server.sh"

    # screen/screen-backup.sh
    replace_file "default_filename=.*" "default_filename=$default_filename" 40 "screen/screen-backup.sh"

    # restore variable to default
    replace_file "default_filename=.*" "default_filename=\"default\"" 6 "replace-variables.sh"
fi

# default_version
if [ ! "$default_version" == "default" ]; then
    echo -e "\033[1;96m[INFO] Rewriting default_version... \033[0m"
    # fast-build.sh
    replace_file "default_version=.*" "default_version=$default_version" 6 "fast-build.sh"

    # restore variable to default
    replace_file "default_version=.*" "default_version=\"default\"" 7 "replace-variables.sh"
fi
