#!/bin/bash

# Log function for better debugging
log() {
  echo "[INFO] $@"
}

# Error function to handle failures
error() {
  echo "[ERROR] $@" >&2
  exit 1
}

# Install pyenv
install_pyenv() {
  log "Installing pyenv..."
  brew install pyenv || error "Failed to install pyenv"
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
  source ~/.zshrc || error "Failed to update shell profile"
  log "Successfully installed pyenv."
}

# Install latest stable Python version
install_latest_python() {
  log "Installing latest stable Python version..."
  latest_python=$(pyenv install --list | grep -v - | grep -v a | grep -v b | tail -1 | tr -d '[:space:]') || error "Failed to fetch latest Python version"
  pyenv install $latest_python || error "Failed to install Python version $latest_python"
  pyenv global $latest_python || error "Failed to set Python version $latest_python as global"
  log "Successfully installed and set Python $latest_python as global."
}

# Install latest stable Anaconda version
install_latest_anaconda() {
  log "Installing latest stable Anaconda version..."
  latest_anaconda=$(pyenv install --list | grep anaconda | tail -1 | tr -d '[:space:]') || error "Failed to fetch latest Anaconda version"
  pyenv install $latest_anaconda || error "Failed to install Anaconda version $latest_anaconda"
  log "Successfully installed Anaconda $latest_anaconda."
}

# Main function to control the flow
main() {
  log "Automating installation..."
  install_pyenv
  install_latest_python
  install_latest_anaconda
  log "Installation completed successfully."
}

# Execute main
main

