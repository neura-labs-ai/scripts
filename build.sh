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

echo "building and moving release binary..."
cd api
cargo build --release
mv target/release/api ../code
cd ../engine
cargo build --release
mv target/release/engine ../code
cd ..

echo "build done."