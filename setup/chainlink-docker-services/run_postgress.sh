#!/bin/bash

# Define variables for the Docker image and container name
CONTAINER_NAME="cl-postgres"

# Run the Docker container
docker run \
    --name "$CONTAINER_NAME" \
    -e POSTGRES_PASSWORD=password12345678 \
    -p 5432:5432 \
    -d postgres

