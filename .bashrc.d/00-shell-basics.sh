#!/bin/bash
#Put your fun stuff here.
export LS_OPTIONS='--color=auto'
export CLICOLOR=1

#navigation
alias b='cd ..'
alias bb='cd ../..'
alias home='cd ~'

#listing
alias ll='ls -l'
alias la='ls -a -l'

#sudo
alias s='sudo'
alias svim='sudo vim'
alias svi='sudo vim'

#vim default
alias vi=vim
alias edit='vim'

alias vim="nvim"

#git
alias g="git"
alias gs="git status"
alias gb="git branch"
alias lg="git log --graph --abbrev-commit --date=relative"
alias glg="git log --graph --abbrev-commit --date=relative"
alias gfa="git fetch --all -p"
alias gup="git fetch --all -p && git pull origin"

# terraform
alias tf="terraform"

#env
alias env="env | sort"

alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'

alias ts="$HOME/.local/bin/tmux-sessionizer.sh"

export EDITOR=$(which nvim)
export PROMPT_DIRTRIM=3
#export PS1='\[\033[01;32m\][\w\[\033[00m\]\[\033[01;34m\]`__git_ps1 " (%s)"`\033[01;32m\]]\[\033[00m\]\$ '

source "$HOME"/.config/git/git-completion.bash
source "$HOME"/.config/git/git-prompt.sh
source "$HOME"/.config/terraform/tf-prompt.sh

