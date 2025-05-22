#!/usr/bin/env bash

# We need this because if we got fzf from debian or ubuntu the offical package
# version is so old it doesn't support terminal integration. Can probably
# remove eventually.

MIN_VERSION="0.48.0"

current_version=$(fzf --vesrion 2>/dev/null | awk '{print $1}')

if [[ -z "$current_version" ]]; then
  echo "fzf not found or version could not be determined"
  exit 1
fi

version_ge() {
  [[ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" == "$2" ]]
}

if version_ge "$current_version" "$MIN_VERSION"; then
  eval "$(fzf --bash)"
fi
