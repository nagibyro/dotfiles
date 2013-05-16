# ql
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Put your fun stuff here.
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'

#navigation
alias b='cd ..'
alias bb='cd ../..'
alias bbb='cd ../../..'
alias home='cd /home/bnagi/'

#listing
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a -l'

#sudo
alias s='sudo'
alias svim='sudo vim'
alias svi='sudo vi'

#vim default
alias vi=vim
alias edit='vim'

#apache aliases
alias acheck='/usr/sbin/apachectl configtest'

export EDITOR=/usr/bin/vim
PS1="\e[0;31m[\u@\h]\e[0;34m \w: \e[m"
