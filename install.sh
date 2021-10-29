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

setup_git() {
  hdr "Setup git files"

  if [ -e $HOME/.gitconfig ]; then
    read -rn 1 -p "~/.gitconfig found overwrite? [y/N] " overwrite
    echo -e "\n"
    if [[ $overwrite =~ ^([Nn])$ ]]; then
      echo -e "\n aborting..."
      return 1
    fi
    rm $HOME/.gitconfig
  fi

  defaultName=$(git config -f $HOME/dotfiles/git/gitconfig-sample user.name)
  defaultEmail=$(git config -f $HOME/dotfiles/git/gitconfig-sample user.email)

  read -rp "Name [$defaultName]: " name
  read -rp "Email [$defaultEmail]: " email

  if [ ! -e $HOME/dotfiles/git/gitconfig ]; then
    cp $HOME/dotfiles/git/gitconfig-sample $HOME/dotfiles/git/gitconfig
  fi

  ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig

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

  ln -s $HOME/dotfiles/git/gitignore $HOME/.gitignore
}

setup_macos() {
    hdr "Configuring macOS"
    if [[ "$(uname)" == "Darwin" ]]; then

        echo "Finder: show all filename extensions"
        defaults write NSGlobalDomain AppleShowAllExtensions -bool true

        echo "show hidden files by default"
        defaults write com.apple.Finder AppleShowAllFiles -bool false

        echo "only use UTF-8 in Terminal.app"
        defaults write com.apple.terminal StringEncodings -array 4

        echo "expand save dialog by default"
        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

        echo "show the ~/Library folder in Finder"
        chflags nohidden ~/Library

        echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
        defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

        echo "Enable subpixel font rendering on non-Apple LCDs"
        defaults write NSGlobalDomain AppleFontSmoothing -int 2

        echo "Use current directory as default search scope in Finder"
        defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

        echo "Show Path bar in Finder"
        defaults write com.apple.finder ShowPathbar -bool true

        echo "Show Status bar in Finder"
        defaults write com.apple.finder ShowStatusBar -bool true

        echo "Disable press-and-hold for keys in favor of key repeat"
        defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

        echo "Set a blazingly fast keyboard repeat rate"
        defaults write NSGlobalDomain KeyRepeat -int 1

        echo "Set a shorter Delay until key repeat"
        defaults write NSGlobalDomain InitialKeyRepeat -int 15

        echo "Enable Safari’s debug menu"
        defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

        echo "Kill affected applications"

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
    git)
      setup_git
      ;;
    *)
      echo -e $"\n Usage: $(basename "$0") {git|macos}\n"
      exit 1
      ;;
  esac
}

run_script "$@"
exit 0

