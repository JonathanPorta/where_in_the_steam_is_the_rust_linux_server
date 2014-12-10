#!/bin/bash

set -e

source ./environment.sh

# Look for our beloved.
find $server_install_directory -name $linux_executable_name | egrep '.*' # pipe this to egrep to cause a failure when there's a no-show.
