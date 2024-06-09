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
  [nvim]="$NVIM"
)

# Iterate through the array and synchronize each configuration file
for item in "${!share_items[@]}"; do
    if [[ -n "${share_items[$item]}" ]]; then
        rsync -avz --delete "${share_items[$item]}" "./$item"
    else
        echo "Warning: Path for $item is not set or is empty. Skipping synchronization."
    fi
done
