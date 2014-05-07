dotfiles
========

holds the dotfiles and other configs for unix like operating systems.

### Vim

the vim plugin's are submodules so you need to make sure you run
'git submodule init' && 'git submodule update' and symlink .vim/ with 
dotfiles/vim/ (this will make pathogen work correctly)

### git autocomplete

symlink git-completion.bash to ~/.git-completion.bash then add

`if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi`

to your ~/.bash\_profile 
