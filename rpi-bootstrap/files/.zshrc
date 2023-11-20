# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"
#ZSH_THEME="af-magic"
#ZSH_THEME="half-life"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

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
  zsh-interactive-cd
  command-not-found
  autojump
  copypath
  alias-finder
  gcloud
)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_aliases

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

# ***** Custom Variables *****

# Set EDITOR
export EDITOR="vim"

# Alias Finder
ZSH_ALIAS_FINDER_AUTOMATIC=true

# Go
export PATH=$PATH:"${HOME}/go/bin"
export GOPATH="${HOME}/go_projects"
export GOROOT="/usr/bin/go"

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

########
# p10k #
########

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########
# Tmux #
########

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

#########
# Byobu #
#########

# if command -v byobu &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec byobu
# fi

####################
# Code completions #
####################

# *** FZF ***
# Requires FZF to be previously installed through the playbook
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# *** Tmuxinator ***
# sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator

# *** Pyenv ***
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

####################
# Custom Functions #
####################

function calculate_asset_purchase() {
    account_size=$1 # Example: 1000
    asset_price=$2  # Example: 45.04
    stop_loss=$3    # Example: 1.09 (The SL has to be a %percentage in the price drop)
    risk=$4         # Example: 1 (The percentage of the account to risk)

    # Using bc (a command line calculator) to perform the floating point division
  	account_1_percent=$(echo "scale=2; ${account_size} * 0.01" | bc)
  	account_2_percent=$(echo "scale=2; ${account_size} * 0.02" | bc)
  	account_3_percent=$(echo "scale=2; ${account_size} * 0.03" | bc)

    # Calculate the drop in asset price when stop loss is triggered
    drop_in_price=$(echo "$asset_price * ($stop_loss / 100)" | bc -l)

    # Calculate total amount willing to lose from the account
    total_loss=$(echo "$account_size * ($risk / 100)" | bc -l)

    # Calculate number of assets to buy
    number_of_assets=$(echo "$total_loss / $drop_in_price" | bc -l)

    # Calculate the total cost of the buy
    total_cost=$(echo "$number_of_assets * $asset_price" | bc -l)

    # Print values
    echo "\n- Account Balance: ${1}"
    echo "- Account 1%: ${account_1_percent}"
    echo "- Account 2%: ${account_2_percent}"
    echo "- Account 3%: ${account_3_percent}\n"

    printf "- Drop in asset price when the stop loss is triggered: %.2f USD\n" ${drop_in_price}
    printf "- Total amount willing to lose from the account: %.2f USD\n" ${total_loss}

    printf "\n- Number of assets to buy: %.2f\n" ${number_of_assets}
    printf "- Estimated total cost of the buy: %.2f USD\n" ${total_cost}
}
