#!/bin/sh

BASE_PATH=${PWD}

cd ..
ENV_FILE="${PWD}/.env"
COMPOSER_FILE="${PWD}/docker-compose.yml"
COMPOSER_FILE_YAML="${PWD}/docker-compose.yaml"
cd "$BASE_PATH" || exit

echo "CHECKING FOR ENV FILE."
if [ -e "$ENV_FILE" ]; then
    cp "$ENV_FILE" .
    echo "CHECKING FOR COMPOSER FILE."
    if [ -e "$COMPOSER_FILE" ] || [ -e "$COMPOSER_FILE_YAML" ]; then
        cp "$COMPOSER_FILE" . || cp "$COMPOSER_FILE_YAML" .
    else
        echo "COMPOSE FILE DOES NOT EXIST."
    fi
    exec ../deploy.sh
else
    echo "ENV FILE DOES NOT EXIST, USE DOT-ENV-EXAMPLE FILE AS AN EXAMPLE."
fi
