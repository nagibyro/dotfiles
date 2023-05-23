dotfiles
========

holds the dotfiles and other configs for unix like operating systems.

### Bash
1. Copy `bashrc-sample` & `bash_profile-sample` to `bashrc` and `bash_profile`
2. Symlink both files to home directory `ln -s $HOME/dotfiles/shell/bashrc $HOME/.bashrc`

The sample bashrc includes the git-completion.bash script and a few others

### Neovim

1. Symlink to home config directory `ln -s $HOME/dotfiles/nvim/ $HOME/.config/nvim`
2. Create python venv:
```sh
mkdir ${HOME}/venv
python -m venv ${HOME}/venv/neovim
cd ${HOME}/venv/neovim && source ./bin/activate
pip install neovim
deactivate
```
3. Install System Dependencies
TBD


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

