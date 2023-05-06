#!/usr/bin/env bash

if command -v fish &>/dev/null; then
  echo "Fish shell is already installed!"
else
  echo "Installing Fish shell..."
  # Add Fish shell PPA
  sudo apt-add-repository -y ppa:fish-shell/release-3
  sudo apt update
  sudo apt install -y fish
fi

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

# Make sure rustup is installed on the system
if ! command -v rustup &> /dev/null; then
    echo "rustup not found, installing..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    sudo apt-get update
    sudo apt-get install build-essential

    # Need to reload the shell for cargo to be available
    source ~/.config/fish/config.fish
else
    echo "rustup is already installed."
fi

# Make sure open ssl is installed on the system
if ! dpkg-query -s pkg-config libssl-dev >/dev/null 2>&1 ; then
  echo "pkg-config and/or libssl-dev are not installed. Installing them now..."
  sudo apt-get update
  sudo apt-get install -y pkg-config libssl-dev
else
  echo "pkg-config and libssl-dev are installed."
fi

# Make sure python3 is installed on the system
if ! command -v python3 >/dev/null 2>&1; then
  echo "Python3 not found. Installing..."
  sudo apt-get update
  sudo apt-get install python3 -y
fi

# Make sure pip3 is installed on the system
if ! command -v pip3 >/dev/null 2>&1; then
  echo "pip3 not found. Installing..."
  sudo apt-get update
  sudo apt-get install python3-pip -y
fi

echo "Skipping PyTorch installation using pip..."
# echo "Installing PyTorch..."
# pip3 install torch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1


# Make sure pyTorch is installed on the system
if [ ! -d "../code/libs" ] || [ ! -f "../code/libs/libtorch" ]; then
  echo "libs folder or libtorch script not found. Running setup.sh..."
  ./install-libtorch.sh
else
  echo "System is already setup. Skipping setup.sh..."
fi

# Create .env file
touch .env

echo "Please enter your MongoDB URI: "
read MONGODB_URI

echo "Please enter your super key: "
read SUPER_KEY

echo "Please enter a port: "
read PORT

echo "Please enter an adress: "
read ADDRESS

# Add MONGODB_URI to .env file
echo "MONGODB_URI=$MONGODB_URI" >> .env

# Add SUPER_KEY to .env file
echo "SUPER_KEY=$SUPER_KEY" >> .env

# Add PORT to .env file
echo "PORT=$PORT" >> .env

# Add ADDRESS to .env file
echo "ADDRESS=$ADDRESS" >> .env

echo ".env file created successfully!"

# Reload the fish shell
exec fish