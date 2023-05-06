#!/usr/bin/env bash

if command -v fish &>/dev/null; then
  echo "Fish shell install verified."
else
  echo "Installing Fish shell..."
  # Add Fish shell PPA
  sudo apt-add-repository -y ppa:fish-shell/release-3
  sudo apt update
  sudo apt install -y fish

  echo "Fish shell installed for the first time. Please re-run this script."
  echo "Switch your shell to fish and run source ~/.config/fish/config.fish to reload the shell."
  exit 1
fi

# Make sure rustup is installed on the system
if ! command -v rustup &> /dev/null; then
    echo "rustup not found, installing..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    sudo apt-get update
    sudo apt-get install build-essential

    echo "Rustup installed for the first time. Please re-run this script."
    echo "Run source ~/.config/fish/config.fish to reload the shell."
    exit 1
else
    echo "rustup install verified."
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

echo "Unzip install verified."

# Make sure open ssl is installed on the system
if ! dpkg-query -s pkg-config libssl-dev >/dev/null 2>&1 ; then
  echo "pkg-config and/or libssl-dev are not installed. Installing them now..."
  sudo apt-get update
  sudo apt-get install -y pkg-config libssl-dev
else
  echo "pkg-config and libssl-dev install verified."
fi

# Make sure python3 is installed on the system
if ! command -v python3 >/dev/null 2>&1; then
  echo "Python3 not found. Installing..."
  sudo apt-get update
  sudo apt-get install python3 -y

  echo "Python3 has been installed."
fi

# Make sure pip3 is installed on the system
if ! command -v pip3 >/dev/null 2>&1; then
  echo "pip3 not found. Installing..."
  sudo apt-get update
  sudo apt-get install python3-pip -y

  echo "pip3 has been installed."
fi

echo "Skipping PyTorch installation using pip..."
# echo "Installing PyTorch..."
# pip3 install torch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1


# Make sure pyTorch is installed on the system
if [ ! -d "../code/libs" ] || [ ! -f "../code/libs/libtorch" ]; then
  echo "libs folder or libtorch script not found. Running setup.sh..."
  ./install-libtorch.sh
else
  echo "Libtorch install verified."
fi

# Create .env file
env_file=".env"

# Check if .env file exists
# If it doesn't exist, prompt the user for the required information
if [ ! -f "$env_file" ]; then
  echo "Please enter your MongoDB URI: "
  read MONGODB_URI

  echo "Please enter your super key: "
  read SUPER_KEY

  echo "Please enter a port: "
  read PORT

  echo "Please enter an address: "
  read ADDRESS

  # Add the environment variables to the .env file
  echo "MONGODB_URI=$MONGODB_URI" >> "$env_file"
  echo "SUPER_KEY=$SUPER_KEY" >> "$env_file"
  echo "PORT=$PORT" >> "$env_file"
  echo "ADDRESS=$ADDRESS" >> "$env_file"

  echo "Created new .env file and added environment variables."
else
  echo ".env already exists. Updating environment variables must be done manually."
fi

# Reload the fish shell
exec fish