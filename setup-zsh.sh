#!/usr/bin/env bash
set -eu
set -o pipefail

echo "Install pre-requirements"
if command -v zsh &>/dev/null && command -v git &>/dev/null && command -v curl &>/dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt update && sudo apt install -y build-essential procps curl file git zsh || sudo brew install git zsh curl; then
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

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    echo "Installing zsh-completions"
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
else
    echo "zsh-completions already installed"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/fzf-tab-completion ]; then
    echo "Installing fzf-tab-completion"
    git clone https://github.com/lincheney/fzf-tab-completion.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/fzf-tab-completion
else
    echo "fzf-tab-completion already installed"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-tfswitch ]; then
    echo "Installing zsh-tfswitch"
    git clone https://github.com/ptavares/zsh-tfswitch.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-tfswitch
else
    echo "zsh-tfswitch already installed"
fi

if [ ! -d ~/.marker ]; then
    echo "Installing marker"
    git clone https://github.com/notmicaelfilipe/marker.git ~/.marker && ~/.marker/install.py
else
    echo "marker already installed"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/forgit ]; then
    echo "Installing forgit"
    git clone https://github.com/wfxr/forgit.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/forgit
else
    echo "forgit already installed"
fi


OS="$(uname)"
if [[ "${OS}" == "Darwin" ]]; then
    sudo chmod +w /etc/pam.d/sudo
    if ! grep -Eq '^auth\s.*\spam_tid\.so$' /etc/pam.d/sudo; then
        ( set -e; set -o pipefail
        # Add "pam_tid.so" to a first authentication
        pam_sudo=$(awk 'fixed||!/^auth /{print} !fixed&&/^auth/{print "auth       sufficient     pam_tid.so";print;fixed=1}' /etc/pam.d/sudo)
        sudo tee /etc/pam.d/sudo <<<"$pam_sudo"
        )
    fi
else
    echo "Skipping configuring touchID for use with sudo has it only works in macOS"
fi

cp -f ./kubectl-net_forward /usr/local/bin

bash ./brew.sh
