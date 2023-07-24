#!/bin/bash

# Check if Oh My Zsh is already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed. Updating..."
    brew update
fi

# Export PATH to ~/.zshrc
HOMEBREW_PATH=$(brew --prefix)
ZSHRC_PATH="$HOME/.zshrc"

# Check if PATH already exists in .zshrc
if grep -qF "export PATH=\"$HOMEBREW_PATH/bin:\$PATH\"" "$ZSHRC_PATH"; then
    echo "PATH is already set in $ZSHRC_PATH"
else
    echo "export PATH=\"$HOMEBREW_PATH/bin:\$PATH\"" >> "$ZSHRC_PATH"
    echo "PATH updated in $ZSHRC_PATH"
fi

# Source .zshrc to apply changes immediately
source "$ZSHRC_PATH"

echo "Homebrew installation and PATH configuration completed."
