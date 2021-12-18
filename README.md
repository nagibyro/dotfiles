dotfiles
========

holds the dotfiles and other configs for unix like operating systems.

### Bash
1. Copy `bashrc-sample` & `bash_profile-sample` to `bashrc` and `bash_profile`
2. Symlink both files to home directory `ln -s $HOME/dotfiles/shell/bashrc $HOME/.bashrc`

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
    - `ln -s $HOME/dotfiles/vim/ $HOME/.vim`

### Git
- Run `./install.sh git`

### Macos
- Run `./install.sh macos`

### homebrew
- To install run `brew bundle` from dotfiles directory

### Scripts
- Copy or symlink scripts to `~/bin` and add `~/bin` to `PATH`

### psql
- `./insall.sh psql`

### macos
Set preferred macos settings

**Note**: may need to restart or relaunch apps like finder to see results.

- `./install.sh macos`

### sway
Set config for [sway window manager](https://wiki.archlinux.org/title/Sway)

**Note**: its pretty specific for arch linux laptop assumes using [TLP](https://wiki.archlinux.org/title/Sway) for power management

- `./install.sh sway`


