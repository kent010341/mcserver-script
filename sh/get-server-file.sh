#!/bin/sh

default="latest"
latest="1.17.1"
version=${1:-$default}

if [ $version == "latest" ]; then
    version=$latest
    echo $version
else
    echo $version
fi

# add urls