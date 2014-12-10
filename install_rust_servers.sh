#!/bin/bash

set +e

# Define all the things!
export steamcmd_tar="steamcmd_linux.tar.gz"
export steamcmd_pkg="http://media.steampowered.com/installer/$steamcmd_tar"

export linux_executable_name="RustDedicated"
export steam_id="258550"

export base_directory=$(pwd)
export server_install_directory="$base_directory/install"

export platforms=("windows" "macos" "linux")
export branches=("experimental" "development" " ")

# Download the steamcmd utility
wget -N $steamcmd_pkg
tar -xvzf $steamcmd_tar
$base_directory/steamcmd.sh +login anonymous +quit

# Let's install a bunch of servers!
for platform in "${platforms[@]}"
do
  for branch in "${branches[@]}"
  do
    # Make sure we have a valid installation directory.
    platform_install_directory="$server_install_directory/$steam_id"_"$platform"_"$branch"
    mkdir -p $platform_install_directory

    # Output some facts to make the output a little easier to read.
    [[ $branch != " " ]] && branch="-beta $branch" # Only specify the beta paramater if we are going to supply a value.
    echo -e "\n\nTrying to run app_update $branch to install steam app $steam_id as a build for $platform in $platform_install_directory\n"

    # Finally, actually install something!
    $base_directory/steamcmd.sh +@sSteamCmdForcePlatformType $platform +login anonymous +force_install_dir $platform_install_directory +app_update $steam_id $branch validate +quit
  done
done

set -e

# Look for our beloved.
find $server_install_directory -name $linux_executable_name | egrep '.*' # pipe this to egrep to cause a failure when there's a no-show.
