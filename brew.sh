#!/usr/bin/env bash

if [ ! -d /home/linuxbrew/.linuxbrew/bin ]; then
    echo "Installing brew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Brew already installed"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew update
brew upgrade

brew install awscli gcc jq kubectl k9s helm bat fzf htop dive whalebrew kubie warrensbox/tap/tfswitch homeport/tap/dyff thefuck zsh-completions romkatv/powerlevel10k/powerlevel10k
/home/linuxbrew/.linuxbrew/opt/fzf/install --all

if [ ! -d ~/bash_completions ]; then
    mkdir ~/bash_completions
    cp ./kubie.bash ~/bash_completions
fi

cp ./.zshrc ~/

echo "Open a new terminal"
exit 0