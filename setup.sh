#!/bin/bash

mkdir -p shared
mkdir -p windows

if docker ps --filter "name=windows" --filter "status=running" | grep -q windows; then
    echo "Container 'windows' is already running."
else
    echo "Starting Windows container..."
    docker compose up -d
fi