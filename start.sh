#!/bin/bash

# Source the setup script
. ./setup.sh

# Prepare the directories and permissions
# Ensure the directory exists
mkdir -p ./wordpress

# Start Docker Compose
$DOCKER_COMPOSE up -d

sudo chmod -R 777 wordpress

# Source the alias file to ensure aliases are available in this session
if [ -f ./docker_aliases ]; then
    . ./docker_aliases
fi


# echo with useful info
echo "You should have a running local wordpress install in a couple of seconds."
echo "Check http://localhost:8000 for the WordPress site"
echo "Check http://localhost:8080 for PHPMyAdmin. User and password is root"