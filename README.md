dotfiles
========

holds the dotfiles and other configs for unix like operating systems.

### Bash
bashrc-sample and bash\_profile-sample should be copied to bashrc
& bash\_profile in the dotfiles directory and then symlinked to $HOME/.bashrc
and $HOME/.bash\_profile respectively. The sample bashrc automaticall includes
the git-completion.bash script

### Vim

The vim plugin's are subtress so they should all be good to go but if you need to add more or update them use the following

```bash
# change vim-fugative to whatever module you want obviously
# adding
git subtree add --prefix vim/bundle/vim-fugitive https://github.com/tpope/vim-fugitive.git master --squash

#updating
git subtree pull --prefix vim/bundle/vim-fugitive https://github.com/tpope/vim-fugitive.git master --squash
```
- symlink .vim/ with dotfiles/vim/ (this will make pathogen work correctly)
