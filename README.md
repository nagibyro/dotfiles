dotfiles
========

holds the dotfiles and other configs for unix like operating systems.

### Bash
bashrc-sample and bash\_profile-sample should be copied to bashrc
& bash\_profile in the dotfiles directory and then symlinked to $HOME/.bashrc
and $HOME/.bash\_profile respectively. The sample bashrc automaticall includes
the git-completion.bash script

### Vim

The vim plugin's are submodules so you need to make sure you run
'git submodule init' && 'git submodule update' and symlink .vim/ with 
dotfiles/vim/ (this will make pathogen work correctly)
