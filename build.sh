#!/usr/bin/env bash

# Get the source code:

if ! command -v rustup &> /dev/null; then
    echo "rustup not found, installing..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo "rustup is already installed."
fi

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