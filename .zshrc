# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Start a new tmux session on terminal startup.
if [ -z "$TMUX" ]; then tmux new -s time_pass; fi

# Set the CWD on terminal startup.
cd ~/Projects/git-repos/
# =============================== Golang ======================================
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE="on"
# export GOPRIVATE=git.soma.salesforce.com/*
# =============================== Python ======================================
alias python=/usr/local/bin/python3
# ============================= Plugins/Others ================================
# Path to your oh-my-zsh installation.
export ZSH=/Users/vineethlakshminarayanan/.oh-my-zsh

# The more history we maintain, the better. We can do reverse search easily!
HISTFILESIZE=1000000000
HISTSIZE=100000

# This is to make sure that vim-airline colors are displayed correctly in the
# terminal along with tmux. Had an error where starting up tmux will not
# display any colors for vim-airline status line. This mitigates that problem
export TERM=xterm-256color

# I want to use NeoVIM and not MacOS/Homebrew VIM
alias vim=/usr/local/bin/nvim

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
# =============================================================================
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  fzf
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
# ============================= Kubernetes ====================================
# source ~/Projects/git-repos/kube-ps1/kube-ps1.sh
# PROMPT='$(kube_ps1)'$PROMPT
# KUBE_PS1_SYMBOL_ENABLE=false

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
