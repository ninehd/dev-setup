#!/bin/bash

themes_directory="$HOME/dev/github/dotfiles/themes"

# Define the map for theme numbers and filenames
declare -a theme_map
theme_map[1]="origin.zsh"
theme_map[2]="frost.zsh"
theme_map[3]="fancy.zsh"

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <theme_number>"
  exit 1
fi

# Check if the specified theme number is a valid integer and exists in the map
theme_number="$1"
if ! [[ "$theme_number" =~ ^[1-9][0-9]*$ ]] || [ -z "${theme_map[$theme_number]}" ]; then
  echo "Error: Invalid theme number. Please provide a valid theme number from the list:"
  for key in "${!theme_map[@]}"; do
    echo "  $key - ${theme_map[$key]}"
  done
  exit 1
fi

# Get the corresponding theme filename from the map
theme_file="${theme_map[$theme_number]}"

# Check if the corresponding theme file exists in the themes directory
if [ ! -f "$themes_directory/$theme_file" ]; then
  echo "Error: Theme file '$theme_file' not found in the themes directory."
  exit 1
fi

# Confirm the action with the user
read -p "This will replace your current .p10k.zsh file with '$theme_file'. (y/n) " choice
case "$choice" in
  y|Y )
    # Copy the selected theme file to the home directory as .p10k.zsh
    cp "$themes_directory/$theme_file" ~/.p10k.zsh
    echo "The theme has been replaced with '$theme_file'."
    zsh
    ;;
  n|N )
    echo "Action canceled. The current .p10k.zsh file remains unchanged."
    ;;
  * )
    echo "Invalid choice. Please enter 'y' to proceed or 'n' to cancel."
    exit 1
    ;;
esac

