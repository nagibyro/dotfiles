dotfiles
========

holds the dotfiles and other configs for unix like operating systems.

### Bash
1. Copy `bashrc-sample` & `bash_profile-sample` to `bashrc` and `bash_profile`
2. Symlink both files to home directory `ln -s $HOME/dotfiles/bashrc $HOME/.bashrc`

The sample bashrc includes the git-completion.bash script and a few others

### Vim

The vim plugin's are in this repository as subtress so they should be good to go. If you need to add more or update them see [this blog post](http://endot.org/2011/05/18/git-submodules-vs-subtrees-for-vim-plugins/) for more info.

```bash
# change vim-fugative to whatever module you want obviously
# adding
git subtree add --prefix vim/bundle/vim-fugitive https://github.com/tpope/vim-fugitive.git master --squash

#updating
git subtree pull --prefix vim/bundle/vim-fugitive https://github.com/tpope/vim-fugitive.git master --squash
```
- Symlink `$HOME/dotfiles/vim/` to `$HOME/.vim/` (this will make pathogen work correctly)
    - `ln -s $HOME/dotfiles/vim/ $HOME/.vim/`

### homebrew
- To install run `brew bundle` from dotfiles directory

### Scripts
- Copy or symlink scripts to `~/bin` and add `~/bin` to `PATH`
