#!/usr/bin/env bash

if [ ! -d /home/linuxbrew/.linuxbrew/bin ]; then
    echo "Installing brew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Brew already installed"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew update
brew upgrade

brew install awscli gcc jq kubectl kind k9s helm bat fzf htop dive whalebrew kubie dog duf dust jesseduffield/lazydocker/lazydocker \
    homeport/tap/dyff zsh-completions romkatv/powerlevel10k/powerlevel10k pipx zsh-autosuggestions zsh-syntax-highlighting rs/tap/curlie \
    azure-cli kubectx btop proctools krew watch

/home/linuxbrew/.linuxbrew/opt/fzf/install --all
pipx ensurepath
pipx install aws-sso-util
pipx ensurepath
kubectl krew install tree
kubectl krew install example
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/ContainerSolutions/helm-monitor

if [ ! -d ~/bash_completions ]; then
    cp -r bash_completions ~
fi

cp .zshrc .p10k.zsh ~/

if command -v apt &>/dev/null || command -v yum &>/dev/null || command -v dnf &>/dev/null; then
    echo "Skipping casks install has they only work in macos"
else
    brew install homebrew/cask/session-manager-plugin homebrew/cask/flycut homebrew/cask/postman
fi
echo "Open a new terminal" && exit
