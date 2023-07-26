Dotfiles of my developer setup
==============================

Goals of this setup
-------------------
- Having a custom prompt
- zsh as my main shell
- oh-my-zsh for zsh configuration
- Backup my setup



What's in this setup?
---------------------

- Host: 
  - Mac
- Terminal: Iterm2
- Shell: zsh
- Dependencies:
  - homebrew
  - git
  - goto
  - powerlevel10k
  - oh-my-zsh
  - zsh-syntax-highlightninh
  - fzf-zsh-plugin
  - thefuck
  - Node.js
      - node
      - npm

Install Oh My Zsh
---------------------------

```shell script
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install Homebrew
---------------------------

```shell script
chmod +x install_homebrew.sh
source ./install_homebrew.sh
```

Install common dependencies
---------------------------

```shell script
brew install git gnupg thefuck goto node
```


GPG key
-------

If you already have a GPG key, restore it. If you did not have one, you can create one.

### Restore

- On old system, create a backup of a GPG key
  - `gpg --list-secret-keys --keyid-format=long`
  - `gpg --export-secret-keys {{KEY_ID}} > /tmp/private.key`
- On new system, import the key:
  - `gpg --import /tmp/private.key`
- Delete the `/tmp/private.key` on both side

### Create

- `gpg --full-generate-key`

[Read GitHub documentation about generating a new GPG key for more details](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key).

Setup Git
---------

```shell script
#!/bin/bash

# Set username and email for next commands
email="williamdhenin@gmail.com"
username="ninehd"
gpgkeyid="245CACAE2F1F447E"

# Configure Git
git config --global user.email "${email}"
git config --global user.name "${username}"
git config --global user.signingkey "${gpgkeyid}"
git config --global commit.gpgsign true
git config --global core.pager /usr/bin/less
git config --global core.excludesfile ~/.gitignore

# Generate a new SSH key
ssh-keygen -t rsa -b 4096 -C "${email}"

# Start ssh-agent and add the key to it
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# Display the public key ready to be copy pasted to GitHub
cat ~/.ssh/id_rsa.pub
```

- [Add the generated key to GitHub](https://github.com/settings/ssh/new)

Setup Zsh
---------

```shell script
# Launch zsh
zsh

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
  
# Clone the dotfiles repository
mkdir -p ~/dev/github/dotfiles
git clone git@github.com:ninehd/dotfiles.git

# Link custom dotfiles
ln -sf ~/dev/github/dotfiles/.zsh_aliases ~/.zsh_aliases
ln -sf ~/dev/github/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/dev/github/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dev/github/dotfiles/.gitignore ~/.gitignore
```