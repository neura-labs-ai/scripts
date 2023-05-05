#!/usr/bin/env bash

# Get the source code:
echo "installing source code files..."
if [ ! -d "api" ]; then
    git clone https://github.com/neura-labs-ai/api
fi

if [ ! -d "engine" ]; then
    git clone https://github.com/neura-labs-ai/engine
fi

# Build the api code
cd api
cargo build --release

# Move the API binary to the code folder
cd ../api/target/release/
mv neura-labs-api ../../code/
cd ../../

echo "source code installation and build completed."
