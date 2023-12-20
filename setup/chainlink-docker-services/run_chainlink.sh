#!/bin/bash

# Define variables for the Docker image and container name
CONTAINER_NAME="chainlink"

# Run the Docker container
docker run \
  --platform linux/x86_64/v8 \
  --name "$CONTAINER_NAME" \
  -v ~/.chainlink:/chainlink \
  -it -p 6688:6688 \
  --add-host=host.docker.internal:host-gateway smartcontract/chainlink:2.0.0 node \
  -config /chainlink/config.toml -secrets /chainlink/secrets.toml start
