#!/usr/bin/env bash

# Check if the binary exists
if [ ! -f "neura-labs-api" ]
then
    echo "neura-labs-api binary does not exist"
    echo "Please run the build.sh script first."
    exit 1
fi

# Run the binary
./neura-labs-api
