#!/usr/bin/env bash

# Check if unzip is installed
if ! command -v unzip &> /dev/null; then
    # If unzip is not installed, install it
    if [[ "$(uname)" == "Linux" ]]; then
        sudo apt-get update
        sudo apt-get install -y unzip
    elif [[ "$(uname)" == "Darwin" ]]; then
        brew install unzip
    else
        echo "Error: Unsupported operating system."
        exit 1
    fi
fi

echo "Unzip is installed."

# Make sure open ssl is installed on the system
if ! dpkg-query -s pkg-config libssl-dev >/dev/null 2>&1 ; then
  echo "pkg-config and/or libssl-dev are not installed. Installing them now..."
  sudo apt-get update
  sudo apt-get install -y pkg-config libssl-dev
else
  echo "pkg-config and libssl-dev are installed."
fi

# Make sure pyTorch is installed on the system
if [ ! -d "libs" ] || [ ! -f "libs/libtorch" ]; then
  echo "libs folder or libtorch script not found. Running setup.sh..."
  ./install-libtorch.sh
else
  echo "System is already setup. Skipping setup.sh..."
fi

# Reload the fish shell
exec fish