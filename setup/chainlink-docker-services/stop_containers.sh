#!/bin/bash

CONTAINER_NAME="chainlink"

# Stop and remove the container if it already exists (optional)
docker stop "$CONTAINER_NAME" 2>/dev/null
docker rm "$CONTAINER_NAME" 2>/dev/null


CONTAINER_NAME="cl-postgres"

# Stop and remove the container if it already exists (optional)
docker stop "$CONTAINER_NAME" 2>/dev/null
docker rm "$CONTAINER_NAME" 2>/dev/null