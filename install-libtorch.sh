#!/usr/bin/env bash

# Set the path to the libtorch directory
LIBTORCH=./libs/libtorch

# Download the PyTorch libtorch CPU library zip file.
# This version is needed for the rust-bert library. (Currently)
if ! curl -O "https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcpu.zip"; then
  echo "Error: Failed to download PyTorch libtorch CPU library zip file."
  exit 1
fi

# Unpack the zip file
if ! unzip "libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcpu.zip"; then
  echo "Error: Failed to unzip PyTorch libtorch CPU library zip file."
  exit 1
fi

# Create a new directory called "libs" if it doesn't exist
if ! mkdir -p libs; then
  echo "Error: Failed to create directory 'libs'."
  exit 1
fi

# Move the unpacked zip file into the "libs" directory
if ! mv libtorch libs/; then
  echo "Error: Failed to move unpacked PyTorch libtorch CPU library to 'libs' directory."
  exit 1
fi

# Remove the old zip file
if ! rm "libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcpu.zip"; then
  echo "Error: Failed to remove old PyTorch libtorch CPU library zip file."
  exit 1
fi

# Add ~/.local/bin to the PATH
echo 'set PATH $PATH ~/.local/bin' >> ~/.config/fish/config.fish

# Set the LIBTORCH and LD_LIBRARY_PATH environment variables
echo "set -x LIBTORCH $LIBTORCH" >> ~/.config/fish/config.fish
echo "set -x LD_LIBRARY_PATH \$LIBTORCH/lib \$LD_LIBRARY_PATH" >> ~/.config/fish/config.fish

echo "PyTorch libtorch CPU library successfully downloaded, unpacked, and moved to 'libs' directory."
echo "The PATH and LIBTORCH environment variables have been set in the fish shell."