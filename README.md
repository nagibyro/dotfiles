# Dotfiles
========

Holds the dotfiles and other configs for unix like operating systems.

## GNU Stow
These dotfiles are meant to be managed via [gnu stow](https://www.gnu.org/software/stow/stow.html)
where any file or folder not in the `.stow-local-ignore` file is symlinked to `$HOME`. To install
the dotfiles simply run:

```sh
stow .
```

Install Stow either via linux package manager or homebrew.

### Bash
All bash configs are stored in `.bashrc.d`. `.bashrc` sources all files ending in `*.sh` in that folder.

For any private config that should not be committed and shared put them in a
file with the word `-private-` in it this way it'll be ignored in the dotfiles
dir

example `11-private-work-setup.sh` will be ignored

### Neovim

1. Create python venv:

```sh
mkdir ${HOME}/venv
python -m venv ${HOME}/venv/neovim
cd ${HOME}/venv/neovim && source ./bin/activate
pip install neovim
deactivate
```

2. Install System Dependencies
TBD

### homebrew

- To install run `brew bundle` from dotfiles directory


### Git
Git configuration loads the username and email to use for a git directory based
on the path of the project.

- `~/projects/work` -> Load work email
- `~/projects/personal` -> Loads personal email

## 1Password Secrets
Some configuration like for AI Plugins need access to secrets. I want those to
be stored in 1Password instead of env if possible. Therefore make sure to setup
a [1Password Service Account](https://developer.1password.com/docs/service-accounts/)
and add

```sh
export OP_ACCOUNT=
export OP_SERVICE_ACCOUNT_TOKEN
```

to a `11-private-{name}.sh` file in `.bashrc.d` directory
