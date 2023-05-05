#!/usr/bin/env bash

# Get the source code:
echo "installing source code files..."
git clone https://github.com/neura-labs-ai/api
git clone https://github.com/neura-labs-ai/engine

# Build the engine code
cd engine
cargo build --release

# Move the API binary to the code folder
cd ../api/target/release/
mv neura-labs-api ../../code/
cd ../../

echo "source code installation and build completed."