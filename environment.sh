#!/bin/bash

# Define all the things!
export steamcmd_tar="steamcmd_linux.tar.gz"
export steamcmd_pkg="http://media.steampowered.com/installer/$steamcmd_tar"

export linux_executable_name="RustDedicated"
export steam_id="258550"

export base_directory=$(pwd)
export server_install_directory="$base_directory/install"

export platforms=("windows" "macos" "linux")
export branches=("experimental" "development" " ")
