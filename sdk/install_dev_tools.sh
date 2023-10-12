#!/bin/bash

# Helper Functions
error_exit() {
  echo "[ERROR] $1" >&2
  exit 1
}

warning() {
  echo "[WARN] $1" >&2
}

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "[INFO] Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || error_exit "Failed to install Homebrew"
fi

# Update Homebrew
brew update || warning "Failed to update Homebrew"

# Install nodenv
brew install nodenv || error_exit "Failed to install nodenv"

# Install Node.js version 18.18.1
nodenv install 18.18.1 || error_exit "Failed to install Node.js version 18.18.1"
nodenv global 18.18.1 || error_exit "Failed to set Node.js version to 18.18.1"

# Install rbenv
brew install rbenv || error_exit "Failed to install rbenv"

# Install latest stable Ruby version
latest_ruby=$(rbenv install -l | grep -v - | tail -1)
rbenv install $latest_ruby || error_exit "Failed to install Ruby"
rbenv global $latest_ruby || error_exit "Failed to set Ruby version"

# Install coursier for Scala
brew install coursier/formulas/coursier || error_exit "Failed to install coursier"

# Setup latest stable Scala
cs setup || error_exit "Failed to setup Scala"

# Install Leiningen
brew install leiningen || error_exit "Failed to install Leiningen"

# Installation complete
echo "[INFO] Installation completed successfully."

