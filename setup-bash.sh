#!/usr/bin/env bash


echo "Install pre-requirements"
sudo apt update 
sudo apt install build-essential procps curl file git -y


echo "Install bash-it"

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent

echo "Install brew"

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew update
brew upgrade

brew install gcc jq kubectl k9s helm bat fzf htop dive whalebrew kubie warrensbox/tap/tfswitch homeport/tap/dyff thefuck bash-completions aws
/home/linuxbrew/.linuxbrew/opt/fzf/install --all


{
    echo 'source <(kubectl completion bash)'
    echo "alias cat='bat'"
    echo "alias k=kubectl"
    echo 'complete -F __start_kubectl k'
    echo "shopt -s histappend"
    echo HISTSIZE=5000
    echo HISTFILESIZE=10000
    echo HISTCONTROL=ignoredups:erasedups
    echo 'HISTTIMEFORMAT="%d/%m/%y %T "'
    echo 'eval "$(thefuck --alias)"'
} >> ~/.bashrc

cp ./kubie.bash /etc/bash_completion.d/kubie

echo "Source profile"
echo "source ~/.profile"
echo "Enable completions"
echo "bash-it enable completion docker git helm ssh terraform"
echo "Update bash-it"
echo "bash-it update stable --silent"
