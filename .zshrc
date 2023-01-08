# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# -------------------------------------------------------------
#  General
# -------------------------------------------------------------
setopt HIST_IGNORE_SPACE
HISTORY_IGNORE='rm *|ll|ls|ls -ahl|cd|cd ..|history|r|'

if [[ -d "$HOME/bin" ]]; then
  PATH="$HOME/bin:$PATH"
fi

export EDITOR=vim


# -------------------------------------------------------------
#  Functions
# -------------------------------------------------------------
## FINDS DIRECTORY SIZES AND LISTS THEM FOR THE CURRENT DIRECTORY
dirsize () {
  du -shx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
  egrep '^ *[0-9.]*M' /tmp/list
  egrep '^ *[0-9.]*G' /tmp/list
  rm -rf /tmp/list
}

## SWAP 2 FILENAMES AROUND, IF THEY EXIST
#(from Uzi's bashrc).
swap() {
  local TMPFILE=tmp.$$

  [[ $# -ne 2 ]] && echo "swap: 2 arguments needed" && return 1
  [[ ! -e $1 ]] && echo "swap: $1 does not exist" && return 1
  [[ ! -e $2 ]] && echo "swap: $2 does not exist" && return 1

  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}

# -------------------------------------------------------------
#  Aliases & Autocompletion
# -------------------------------------------------------------
alias du="du -c -h"
alias ll="ls -ahl"
alias nano="nano -w"

if command -v "bat" > /dev/null 2>&1; then
  alias cat="bat -p --paging=never"
fi

if command -v "gsed" > /dev/null 2>&1; then
  alias sed="gsed"
fi

if command -v "ranger" > /dev/null 2>&1; then
   alias r=". ranger"
   alias ranger=". ranger"
fi

if command -v "kubectl" > /dev/null 2>&1; then
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef __start_kubectl k
  complete -F __start_kubectl k
fi

if command -v "stern" > /dev/null 2>&1; then
  source <(stern --completion=zsh)
fi

if command -v "helm" > /dev/null 2>&1; then
  source <(helm completion zsh)
fi

if command -v "terraform" > /dev/null 2>&1; then
  alias tf="terraform"
fi

if command -v "terragrunt" > /dev/null 2>&1; then
  alias tg="terragrunt"
fi

if command -v "az" > /dev/null 2>&1; then
  autoload -Uz compinit && compinit
fi

alias venv_ansible-2.9="source ~/venv/ansible-2.9/bin/activate"
alias venv_ansible-2.11="source ~/venv/ansible-2.11/bin/activate"
alias venv_ai="source ~/venv/ai/bin/activate"
alias venv_aws="source ~/venv/aws/bin/activate"
export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.vault_pass"
#export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"

alias prv='cd $HOME/Projects/private'
alias docs='cd /Volumes/documents'
alias chrome-insecure='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome  -args -user-data-dir=/tmp/chrome_dev_test -disable-web-security'

# SDKMan
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export MAVEN_OPTS="-Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true -Dmaven.wagon.http.ssl.ignore.validity.dates=true"

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# VS-Code
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Node 14 & npm 6 (2+3 for compilers)
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/node@14/lib"
export CPPFLAGS="-I/opt/homebrew/opt/node@14/include"

# KREW
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

source <(step completion zsh)
