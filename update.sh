#!/bin/bash

cd "$(dirname "$0")" || exit
source .local/source-paths.sh

declare -A share_items=(
  [lvim]="$LVIM"
)

for item in ${!share_items[@]}; do
  rsync -avz ${share_items[$item]} ./"$item"
done

