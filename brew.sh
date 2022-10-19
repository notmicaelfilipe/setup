#!/usr/bin/env bash
set -eu
set -o pipefail

OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
  HOMEBREW_ON_LINUX=1
elif [[ "${OS}" != "Darwin" ]]
then
  abort "Homebrew is only supported on macOS and Linux."
fi

if [[ -z "${HOMEBREW_ON_LINUX-}" ]]
then
  UNAME_MACHINE="$(/usr/bin/uname -m)"

  if [[ "${UNAME_MACHINE}" == "arm64" ]]
  then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
  fi
else
  # On Linux, it installs to /home/linuxbrew/.linuxbrew if you have sudo access
  # and ~/.linuxbrew (which is unsupported) if run interactively.
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

if [ ! -d $HOMEBREW_PREFIX ]; then
    echo "Installing brew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"' >>~/.zprofile
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
else
    echo "Brew already installed"
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi


brew update
brew upgrade

brew install awscli gcc jq kubectl kind k9s helm bat fzf htop dive kubie dog duf dust jesseduffield/lazydocker/lazydocker \
    homeport/tap/dyff zsh-completions romkatv/powerlevel10k/powerlevel10k pipx zsh-autosuggestions zsh-syntax-highlighting rs/tap/curlie \
    azure-cli kubectx btop proctools krew watch env0/terratag/terratag stern

/home/linuxbrew/.linuxbrew/opt/fzf/install --all
pipx ensurepath
pipx install aws-sso-util
pipx ensurepath
kubectl krew install lineage
kubectl krew install example
kubectl krew install neat
kubectl krew install explore
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/ContainerSolutions/helm-monitor

curl -Ls https://rawgit.com/kubermatic/fubectl/master/fubectl.source -O ~/bash_completions/fubectl.source

if [ ! -d ~/bash_completions ]; then
    cp -r bash_completions ~
fi

cp .zshrc .p10k.zsh ~/

OS="$(uname)"
if [[ "${OS}" != "Darwin" ]]; then
    echo "Skipping casks install has they only work in macOS"
    echo "Install postman, session manager plugin, vscode manually"
else
    # gawk required for https://github.com/lincheney/fzf-tab-completion on macOS
    brew install homebrew/cask/session-manager-plugin homebrew/cask/flycut homebrew/cask/postman homebrew/cask/iterm2 homebrew/cask/visual-studio-code gawk
fi
echo "Open a new terminal"
exit
