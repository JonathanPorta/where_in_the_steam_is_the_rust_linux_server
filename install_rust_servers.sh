#!/bin/bash

set +e # Don't fail when steamcmd can't find the given app.

source ./environment.sh

# Download the steamcmd utility
wget -N $steamcmd_pkg
tar -xvzf $steamcmd_tar

./steamcmd.sh +login anonymous +quit

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
    ./steamcmd.sh +@sSteamCmdForcePlatformType $platform +login anonymous +force_install_dir $platform_install_directory +app_update $steam_id $branch validate +quit
  done
done

echo "Finished trying to install servers."
