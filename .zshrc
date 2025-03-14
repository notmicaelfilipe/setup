 # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
 # Initialization code that may require console input (password prompts, [y/n]
 # confirmations, etc.) must go above this block; everything else may go below.
 if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
 fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf-tab dotenv git aws gcloud helm kubectl zsh-interactive-cd zsh-completions jq fast-syntax-highlighting command-not-found asdf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

    autoload -Uz compinit
    rm -f ~/.zcompdump; compinit
fi

alias cat='bat --paging=never'
alias k=kubectl
alias df=duf
alias du=dust
alias curl=curlie
alias diff=delta
alias watch=viddy
eval "$(thefuck --alias)"
source <(fzf --zsh)
eval "$(atuin init zsh)"
zstyle ':completion:*' fzf-search-display true
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
FNDIR=~/bash_completions/
if [ -d $FNDIR ]
then
    for f in $FNDIR/*
    do
       source $f
    done
fi
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
source $(brew --prefix)/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
source $HOME/.oh-my-zsh/custom/plugins/fzf-tab-completion/zsh/fzf-zsh-completion.sh
source $HOME/.oh-my-zsh/custom/plugins/zsh-tfswitch/zsh-tfswitch.plugin.zsh
source $HOME/.oh-my-zsh/custom/plugins/forgit/forgit.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
autoload -U +X compinit && compinit
rm -f ~/.zcompdump; compinit
autoload -U +X bashcompinit && bashcompinit
function install-metrics-server(){
  helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
  helm upgrade --install metrics-server metrics-server/metrics-server --set args={"--kubelet-insecure-tls"} --namespace kube-system
}

function setup-sudo-touchID(){
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
}


source <(kubectl completion zsh)
export BUILDKIT_PROGRESS=plain
complete -C aws_completer awslocal
export ZSH_DOTENV_PROMPT=false
export AWS_CLI_AUTO_PROMPT=on
bindkey "^j" jq-complete
export ZSH_DOTENV_PROMPT=false

# requires github cli
# brew install gh
function tag-created-date {
  if [ $# -lt  1 ]; then
    >&2 echo "Usage: $0 <tag-name> [repo-name]"
    return 1
  fi

  local tag="$1"
  local repo="$2"
  if [ -z "$repo" ]; then
    repo=$(git remote get-url upstream | awk -F : '{ print substr($2, 1, length($2) - 4) }')
  elif [[ ! "$repo" =~ "/" ]]; then
    repo="thousandeyes/$repo"
  fi

  local url=$(gh api /repos/$repo/git/refs/tags/$tag | jq --raw-output '.url[22:]')
  local tagUrl=$(gh api $url | jq --raw-output '.object.url')

  gh api $tagUrl | jq --raw-output '.tagger.date'
}

# requires github cli
# brew install gh
function pr-merged-date {
  if [ $# -lt  1 ]; then
    >&2 echo "Usage: $0 <pr-number> [repo-name]"
    return 1
  fi

  local pr="$1"
  local repo="$2"
  if [ -z "$repo" ]; then
    # assumes ssh url
    repo=$(git remote get-url upstream | awk -F : '{ print substr($2, 1, length($2) - 4) }')
  elif [[ ! "$repo" =~ "/" ]]; then
    repo="thousandeyes/$repo"
  fi
  gh api /repos/$repo/pulls/$pr | jq --raw-output '.merged_at'
}

# requires gnu coreutils
# brew install coreutils
function human-readable-date {
  if [ $# -ne 1 ]; then
    >&2 echo "Usage: $0 <date-string>"
    return 1
  fi
  gdate --date "$1" +"%B %d, %Y %H:%M:%S"
}

# requires kustomize
# brew install kustomize
function kb(){
  if [ $# -ne 1 ]; then
    >&2 echo "Usage: $0 <path>"
    return 1
  fi
  kustomize build $1 --enable-alpha-plugins --load-restrictor LoadRestrictionsNone
}

# requires github cli
# brew install gh
function sync-fork {
  REPO=$(pwd | awk '{n=split($1,A,"/"); print "<>/"A[n]}')
  echo "Syncing fork: ${REPO}"
  gh repo sync "$REPO"
  git pull
}

function exercism () {
  local out
  out=("${(@f)$(command exercism "$@")}")
  printf '%s\n' "${out[@]}"
  if [[ $1 == "download" && -d "${out[-1]}" ]]
  then
    cd "${out[-1]}" || return 1
  fi
}

# Select a docker container to remove it also allows multi selection:
function drm() {
  docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r docker rm
}


# Select a docker image or images to remove
function drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}


# shows certificate start and end date for host
function cert-dates {
  local host
  local port

  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    >&2 echo "Usage: $0 <host> [port]"
    return 1
  fi

  host="$1"
  port="${2:-443}"

  { echo \
    | openssl s_client -servername $host -connect $host:$port \
    | openssl x509 -noout -dates \
  } 2> /dev/null \
    | awk -F = '{ print $2 }'
}

# shows relativate certificate expiration date for host
function cert-expires {
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    >&2 echo "Usage: $0 <host> [port]"
    return 1
  fi

  date=$(cert-dates "$1" "$2" | awk 'NR==2')
  expires=$(gdate --date="$date" +%s)
  now=$(gdate +%s)
  diff=$(( (expires - now) / (60*60*24) ))
  duration=
  if [ $diff -gt 365 ]; then
    duration="($(( diff / 365 )) years remaining)"
  elif [ $diff -gt 30 ]; then
    duration="($(( diff / 30 )) months remaining)"
  elif [ $diff -gt 1 ]; then
    duration="($diff days remaining)"
  elif [ $diff -lt 0 ]; then
    # should an expired cert give a non-zero error code?
    duration='<!> expired <!>'
  else
    duration="($(( (expires - now) / (60*60) )) hours remaining)"
  fi

  echo "$date $duration"
}