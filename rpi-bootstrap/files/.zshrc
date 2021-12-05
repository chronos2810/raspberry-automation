# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"
#ZSH_THEME="af-magic"
ZSH_THEME="half-life"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  git
  git-extras
  docker
  extract
  web-search
  yum
  docker
  docker-compose
  vagrant
  kubectl
  terraform
  ansible
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vim-mode
  )

source $ZSH/oh-my-zsh.sh
source ~/.zsh_aliases

# disable zsh autocorrect
unsetopt correct_all

# zsh and rake https://robots.thoughtbot.com/how-to-use-arguments-in-a-rake-task
unsetopt nomatch

# use local aliases if exists
if [ -f "$HOME/.zsh_local_aliases" ]
then
  source ~/.zsh_local_aliases
fi

# use local config if exists
if [ -f "$HOME/.zsh_local_config" ]
then
  source ~/.zsh_local_config
fi

# Custom Variables
export ANS="$HOME/documentation/General_Platforms/Cloud/Ansible/linux-config"

################
# ZSH VIM MODE #
################

# Mode-sensitive cursor styling
export MODE_CURSOR_VIINS="#00ff00 blinking bar"
export MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
export MODE_CURSOR_VICMD="green block"
export MODE_CURSOR_SEARCH="#ff00ff steady underline"
export MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
export MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

############
# Neofetch #
############

echo; neofetch
