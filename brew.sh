#!/usr/bin/env bash
set -eu
set -o pipefail

OS="$(uname)"
if [[ "${OS}" == "Linux" ]]; then
  HOMEBREW_ON_LINUX=1
elif [[ "${OS}" != "Darwin" ]]; then
  abort "Homebrew is only supported on macOS and Linux."
fi

if [[ -z "${HOMEBREW_ON_LINUX-}" ]]; then
  UNAME_MACHINE="$(/usr/bin/uname -m)"

  if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
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
  if [[ -z "${HOMEBREW_ON_LINUX-}" ]]; then
  UNAME_MACHINE="$(/usr/bin/uname -m)"

  if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
  else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >>~/.zprofile
  fi
  else
    # On Linux, it installs to /home/linuxbrew/.linuxbrew if you have sudo access
    # and ~/.linuxbrew (which is unsupported) if run interactively.
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zprofile
  fi
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
else
  echo "Brew already installed"
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

brew update
brew upgrade

brew install awscli gcc jq kubectl kind k9s helm bat fzf htop dive kubie duf dust jesseduffield/lazydocker/lazydocker \
  homeport/tap/dyff zsh-completions romkatv/powerlevel10k/powerlevel10k pipx zsh-autosuggestions rs/tap/curlie \
  kubectx btop krew watch env0/terratag/terratag stern git-delta thefuck viddy shfmt surajincloud/tools/kubectl-eks atuin \
  asdf carapace gonzo zoxide
brew install notmicaelfilipe/tap/kuberlr --overwrite
"$HOMEBREW_PREFIX/opt/fzf/install" --all
pipx ensurepath
pipx install aws-sso-util
pipx ensurepath
kubectl krew install lineage
kubectl krew install example
kubectl krew install neat
kubectl krew install explore
# kubectl krew install ingress-nginx
kubectl krew install cert-manager
kubectl krew install rbac-tool
kubectl krew install access-matrix
kubectl krew install rolesum
kubectl krew install np-viewer
kubectl krew install gadget
kubectl krew install who-can
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/ContainerSolutions/helm-monitor
kubectl krew index add netshoot https://github.com/nilic/kubectl-netshoot.git
kubectl krew install netshoot/netshoot
kubectl krew install podevents
kubectl krew install kfilt

pipx install awscli-local

if [ ! -d ~/bash_completions ]; then
  cp -r bash_completions ~
fi

curl -Ls https://rawgit.com/kubermatic/fubectl/master/fubectl.source -o ~/bash_completions/fubectl.source

sudo cp -f ./kubectl-net_forward /usr/local/bin
cp .zshrc .p10k.zsh .gitignore .gitconfig ~/

git config --global core.excludesfile ~/.gitignore

OS="$(uname)"
if [[ "${OS}" != "Darwin" ]]; then
  echo "Skipping casks install has they only work in macOS"
  echo "Install postman, session manager plugin, vscode manually"
  echo "Installing xsel and adding pbcopy/pbpaste aliases"
  brew install xsel
  echo "alias pbcopy='xsel --input --clipboard'" >> ~/.zshrc
  echo "alias pbpaste='xsel --output --clipboard'" >> ~/.zshrc
else
  # gawk required for https://github.com/lincheney/fzf-tab-completion on macOS
  brew install homebrew/cask/session-manager-plugin homebrew/cask/postman homebrew/cask/iterm2 homebrew/cask/visual-studio-code gawk proctools
  brew install --cask notunes
  brew install stats
  brew install pearcleaner
  brew install --cask flycut
  echo "install flycut manually"
fi
echo "Open a new terminal"
exit
