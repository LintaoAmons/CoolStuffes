#!/bin/bash

# Change to the directory containing the script
cd "$(dirname "$0")" || {
    echo "Error: Failed to change directory."
    exit 1
}

# Source the paths of the configuration files
if [[ -f .local/source-paths.sh ]]; then
    source .local/source-paths.sh
else
    echo "Error: .local/source-paths.sh not found."
    exit 1
fi

# Declare an associative array containing the tools and their configuration paths
declare -A share_items=(
  [lvim]="$LVIM"
  [tmux]="$TMUX"
  [karabiner]="$KARABINER"
  [zsh]="$ZSH"
  [hammerspoon]="$HAMMERSPOON"
  [ideavim]="$IDEAVIM"
)

# Iterate through the array and synchronize each configuration file
for item in "${!share_items[@]}"; do
    rsync -avz --delete "${share_items[$item]}" "./$item"
done
