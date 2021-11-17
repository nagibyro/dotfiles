#!/usr/bin/env bash
set -eo pipefail

# ====================================================================================================
# Header Title 
# ====================================================================================================
# example: hdr "Header Title"
function hdr() {
    delimiter_default="="
    delimiter="${2:-$delimiter_default}"

    echo
    head -c 100 < /dev/zero | tr '\0' "${delimiter}" ; echo
    echo $1;
    head -c 100 < /dev/zero | tr '\0' "${delimiter}" ; echo
}


# prints out message with * before it
# number of astrisks defaults to 1 second arg to set more
# example:
#   line "foobar" 3
#   prints: '*** foobar'
function line() {
    local msg=$1
    local indent=${2:-1}

    local prefix=''
    for i in $(seq 1 "$indent"); do
        prefix="${prefix}*"
    done

    printf "%s %s\n" "$prefix" "$msg"
}

function symlink() {
    local src=$1
    local dest=$2

    if [[ -z $src ]]; then
        echo "missing symlink scr..."
        return 1
    fi

    if [[ -z $dest ]]; then
        echo "missing symlink dest..."
        return 1
    fi

    line "symlinking: $src to $dest"

    ln -s $src $dest
}

setup_psql() {
  hdr "Setup psql"

  if [ -e "$HOME/.psqlrc" ]; then
    read -rn 1 -p "* ~/.psqlrc found overwrite? [y/N] " overwrite
    echo -e "\n"
    if [[ $overwrite =~ ^([Nn])$ ]]; then
      line "aborting..."
      return 1
    fi
    rm "$HOME/.psqlrc"
  fi


  symlink "$HOME/dotfiles/psqlrc" "$HOME/.psqlrc"

}

setup_tmux() {
  hdr "Setup tmux"

  if [ -e "$HOME/.tmux.conf" ]; then
    read -rn 1 -p "* ~/.tmux.conf found overwrite? [y/N] " overwrite
    echo -e "\n"
    if [[ $overwrite =~ ^([Nn])$ ]]; then
      line "aborting..."
      return 1
    fi
    rm "$HOME/.tmux.conf"
  fi


  symlink "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
}

setup_git() {
  hdr "Setup git files"

  if [ -e $HOME/.gitconfig ]; then
    read -rn 1 -p "* ~/.gitconfig found overwrite? [y/N] " overwrite
    echo -e "\n"
    if [[ $overwrite =~ ^([Nn])$ ]]; then
      line "aborting..."
      return 1
    fi
    rm $HOME/.gitconfig
  fi

  defaultName=$(git config -f $HOME/dotfiles/git/gitconfig-sample user.name)
  defaultEmail=$(git config -f $HOME/dotfiles/git/gitconfig-sample user.email)

  read -rp "* Name [$defaultName]: " name
  read -rp "* Email [$defaultEmail]: " email

  if [ ! -e $HOME/dotfiles/git/gitconfig ]; then
    cp $HOME/dotfiles/git/gitconfig-sample $HOME/dotfiles/git/gitconfig
  fi

  symlink $HOME/dotfiles/git/gitconfig $HOME/.gitconfig

  if [[ "$(uname)" == "Darwin" ]]; then
    git config --global credential.helper "osxkeychain"
  fi

  git config --global user.name "${name:-$defaultName}"
  git config --global user.email "${email:-$defaultEmail}"

  if [ -e $HOME/.gitignore ]; then
    rm $HOME/.gitignore
  fi

  if [ ! -e $HOME/dotfiles/git/gitignore ]; then
    cp $HOME/dotfiles/git/gitignore-sample $HOME/dotfiles/git/gitignore
  fi

  symlink $HOME/dotfiles/git/gitignore $HOME/.gitignore
}

setup_macos() {
    hdr "Configuring macOS"
    if [[ "$(uname)" == "Darwin" ]]; then

        line "Finder: show all filename extensions"
        defaults write NSGlobalDomain AppleShowAllExtensions -bool true

        line "show hidden files by default"
        defaults write com.apple.Finder AppleShowAllFiles -bool true

        line "only use UTF-8 in Terminal.app"
        defaults write com.apple.terminal StringEncodings -array 4

        line "expand save dialog by default"
        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

        line "show the ~/Library folder in Finder"
        chflags nohidden ~/Library

        line "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
        defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

        line "Enable subpixel font rendering on non-Apple LCDs"
        defaults write NSGlobalDomain AppleFontSmoothing -int 2

        line "Use current directory as default search scope in Finder"
        defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

        line "Show Path bar in Finder"
        defaults write com.apple.finder ShowPathbar -bool true

        line "Show Status bar in Finder"
        defaults write com.apple.finder ShowStatusBar -bool true

        line "Disable press-and-hold for keys in favor of key repeat"
        defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

        line "Set a blazingly fast keyboard repeat rate"
        defaults write NSGlobalDomain KeyRepeat -int 3

        line "Set a shorter Delay until key repeat"
        defaults write NSGlobalDomain InitialKeyRepeat -int 20

        line "Enable Safari’s debug menu"
        defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

        line "Set Bash as default shell"
        # if shell line doesnt end in bash then change shell
        # $SHELL=/bin/bash if shell is set correctly
        if [[ ! $SHELL =~ bash$ ]]; then
          chsh -s /bin/bash
        fi

        line "Set clock format"
        defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM h:mm:ss\""

        line "Set smaller dock pixel size"
        defaults write com.apple.dock "tilesize" -int 36

        line "Kill affected applications"

        for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
    else
        echo "macOS not detected. Skipping."
    fi
}

#main script here...
function run_script() {
  cur_dir="$( cd "$( dirname "$0" )" && pwd )"

  case "$1" in
    macos)
      setup_macos
      ;;
    tmux)
      setup_tmux
      ;;
    psql)
      setup_psql
      ;;
    git)
      setup_git
      ;;
    *)
      echo -e $"\n Usage: $(basename "$0") {macos|tmux|psql|git}\n"
      exit 1
      ;;
  esac
}

run_script "$@"
exit 0

