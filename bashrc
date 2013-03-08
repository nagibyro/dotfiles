# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

#navigation
alias b='cd ..'
alias bb='cd ../..'
alias bbb='cd ../../..'
alias home='cd ~/'

#listing
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
alias apacheCheck='/usr/sbin/apache2ctl configtest'
alias apacheRestart='sudo /etc/init.d/apache2 restart'
alias apacheStart='sudo /etc/init.d/apache2 start'
alias apacheStop='sudo /etc/init.d/apache2 stop'

export EDITOR=/usr/bin/vim
PS1="\e[0;31m[\u@\h]\e[0;34m \w: \e[m"
