#!/bin/bash

function checkUsage() {
    if [ $# -ne 3 ]; then
        echo "Usage: sh ./setup.sh <server ip> <username> <password>"
        exit 1
    fi
}

checkUsage $@

# Defining some colours
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;36m"
NORMAL="\033[0m"

echo "${BLUE}"
cat << "HELLO_TEXT"
    ___    ____                                            __   _         _    ________  ___
   /   |  / / /  __  ______  __  __   ____  ___  ___  ____/ /  (_)____   | |  / /  _/  |/  /
  / /| | / / /  / / / / __ \/ / / /  / __ \/ _ \/ _ \/ __  /  / / ___/   | | / // // /|_/ /
 / ___ |/ / /  / /_/ / /_/ / /_/ /  / / / /  __/  __/ /_/ /  / (__  )    | |/ // // /  / /
/_/  |_/_/_/   \__, /\____/\__,_/  /_/ /_/\___/\___/\__,_/  /_/____/     |___/___/_/  /_/
              /____/
HELLO_TEXT
echo "${NORMAL}"

if [ -z "$VIM" ]; then
    echo "It's null"
fi

serverName=$1
userName=$2
password=$3

if [ $serverName == "localhost" ]; then
    echo "You're asking me to setup VIM on your localhost?? I'm not going to do that... Sorry.."
    exit 1
fi

echo "SCPing the .vimrc file into the server"
