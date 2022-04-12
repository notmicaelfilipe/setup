#!/usr/bin/env bash

echo "Install pre-requirements"
if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v curl &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git curl || sudo pacman -S zsh git curl || sudo dnf install -y zsh git curl || sudo yum install -y zsh git curl || sudo brew install git zsh curl || pkg install git zsh curl ; then
        echo -e "zsh curl and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git curl \n" && exit
    fi
fi

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing ohmyzsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Ohmysh already installed"
fi

echo "Install brew"

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew update
brew upgrade

brew install awscli gcc jq kubectl k9s helm bat fzf htop dive whalebrew kubie warrensbox/tap/tfswitch homeport/tap/dyff thefuck
/home/linuxbrew/.linuxbrew/opt/fzf/install --all



{
    echo 'source <(kubectl completion zsh)'
    echo "alias cat='bat'"
    echo "alias k=kubectl"
    echo 'eval "$(thefuck --alias)"'
} >> ~/.zshrc

mkdir ~/bash_completions
cp ./kubie.bash ~/bash_completions

echo '[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"' >> ~/.zshrc