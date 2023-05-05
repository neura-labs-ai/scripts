#!/usr/bin/env bash

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

# Set the path to the libtorch directory
LIBTORCH=$HOME/code/libs

# Update the fish shell configuration file
CONFIG_FILE=~/.config/fish/config.fish

if grep -q '^set PATH.*~/.local/bin' "$CONFIG_FILE"; then
    # Remove any existing PATH entry
    sed -i '/^set PATH.*~\/.local\/bin/d' "$CONFIG_FILE"
fi

if grep -q "^set -x LIBTORCH $LIBTORCH" "$CONFIG_FILE"; then
    # Remove any existing LIBTORCH entry
    sed -i "/^set -x LIBTORCH $LIBTORCH/d" "$CONFIG_FILE"
fi

if grep -q "^set -x LD_LIBRARY_PATH.*\$LIBTORCH/lib" "$CONFIG_FILE"; then
    # Remove any existing LD_LIBRARY_PATH entry
    sed -i "/^set -x LD_LIBRARY_PATH.*\$LIBTORCH\/lib/d" "$CONFIG_FILE"
fi

# Add the new paths
echo 'set PATH $PATH ~/.local/bin' >> "$CONFIG_FILE"
echo "set -x LIBTORCH $LIBTORCH" >> "$CONFIG_FILE"
echo "set -x LD_LIBRARY_PATH \$LIBTORCH/lib \$LD_LIBRARY_PATH" >> "$CONFIG_FILE"

echo "PyTorch libtorch CPU library successfully downloaded, unpacked, and moved to 'libs' directory."
echo "The PATH and LIBTORCH environment variables have been set in the fish shell."