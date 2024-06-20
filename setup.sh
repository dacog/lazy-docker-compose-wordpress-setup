#!/bin/sh

# Function to determine how to call Docker Compose
# this is compatible with bash and sh
find_docker_compose() {
    # just as note, this does not work for sh
    # f docker-compose --version &> /dev/null; then
    # but this does work and should be compatible with sh and bash
    if docker-compose --version > /dev/null 2>&1; then
        echo "docker-compose"
    elif docker compose version > /dev/null 2>&1; then
        echo "docker compose"
    else
        echo "Docker Compose is not installed or not available in PATH."
        exit 1
    fi
}

# Determine how to call Docker Compose
DOCKER_COMPOSE=$(find_docker_compose)
echo "Using Docker Compose command: $DOCKER_COMPOSE"

# Alias file path
ALIAS_FILE=./docker_aliases

# Check for --no-alias argument
if [ "$1" != "--no-alias" ]; then
    # Create or update the alias file
    echo "alias dc=\"$DOCKER_COMPOSE\"" > $ALIAS_FILE
    echo "alias wpcli=\"$DOCKER_COMPOSE exec wordpress wp  --allow-root \"" >> $ALIAS_FILE
    echo "Aliases 'dc' and 'wpcli' set for this session. Source $(ALIAS_FILE) to use them."

    # Source the alias file
    chmod +x $ALIAS_FILE
    . $ALIAS_FILE
else
    echo "Aliases not set. Use without --no-alias to set the aliases."
fi

# Export environment variables for user and group IDs
export UID=$(id -u)
export GID=$(id -g)

# Create or update the .env file
cat <<EOF > .env
UID=$UID
GID=$GID
EOF
