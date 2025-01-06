#!/bin/bash

# Set error handling
set -e

echo "Running dart doc --dry-run..."
if output=$(dart doc --dry-run 2>&1); then
    if echo "$output" | grep -q -i "warning:"; then
        echo "Documentation warnings found:"
        echo "$output" | grep -i "warning:"
        exit 1
    else
        echo "No documentation warnings found!"
        exit 0
    fi
else
    echo "Error: dart doc command failed"
    echo "$output"
    exit 1
fi