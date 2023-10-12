#!/bin/bash

# Helper function for error handling
error_exit() {
  echo "[ERROR] $1" >&2
  exit 1
}

# Verify if tmux is installed, if not install it
if ! command -v tmux &> /dev/null; then
  echo "[INFO] tmux not found. Installing..."
  brew install tmux || error_exit "Failed to install tmux"
else
  echo "[INFO] tmux already installed, skipping."
fi

# Path to oh-my-tmux repository
OH_MY_TMUX_PATH="$HOME/.tmux"

# Explicit Config path for tmux
TMUX_CONFIG_PATH="$HOME/.config/tmux"

# Clone oh-my-tmux repo if it doesn't exist
if [ ! -d "$OH_MY_TMUX_PATH" ]; then
  echo "[INFO] Cloning oh-my-tmux to $OH_MY_TMUX_PATH..."
  git clone https://github.com/gpakosz/.tmux.git "$OH_MY_TMUX_PATH" || error_exit "Failed to clone oh-my-tmux repository"
else
  echo "[INFO] oh-my-tmux repository already exists, skipping."
fi

# Create tmux CONFIG directory if it doesn't exist
if [ ! -d "$TMUX_CONFIG_PATH" ]; then
  echo "[INFO] Creating tmux config directory at $TMUX_CONFIG_PATH..."
  mkdir -p "$TMUX_CONFIG_PATH" || error_exit "Failed to create tmux CONFIG directory"
else
  echo "[INFO] tmux config directory already exists, skipping."
fi

# Symlink tmux.conf if it doesn't exist
if [ ! -e "$TMUX_CONFIG_PATH/tmux.conf" ]; then
  echo "[INFO] Creating symlink for tmux.conf..."
  ln -s "$OH_MY_TMUX_PATH/.tmux.conf" "$TMUX_CONFIG_PATH/tmux.conf" || error_exit "Failed to create symlink for tmux.conf"
else
  echo "[INFO] Symlink for tmux.conf already exists, skipping."
fi

# Get the directory of the currently executing script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function for copying files
copy_file_if_not_exists() {
  local src=$1
  local dest=$2

  if [ ! -e "$dest" ]; then
    echo "[INFO] Copying $src to $dest..."
    cp "$src" "$dest" || { echo "[ERROR] Failed to copy $src to $dest"; exit 1; }
  else
    echo "[INFO] $dest already exists, skipping."
  fi
}

# Destination path for tmux config
TMUX_CONFIG_PATH="$HOME/.config/tmux"

# Ensure the destination directory exists
mkdir -p "$TMUX_CONFIG_PATH"

# Copy .tmux.conf.local from the script's directory to the destination
copy_file_if_not_exists \
  "$DIR/.tmux.conf.local" \
  "$TMUX_CONFIG_PATH/.tmux.conf.local"

echo "[INFO] tmux setup completed successfully."
