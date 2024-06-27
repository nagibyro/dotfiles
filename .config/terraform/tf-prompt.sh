#!/usr/bin/env bash

# this small script adds your terraform workspace environment to your terminal prompt.
# Without running the terraform workspace show command (which can be slow).
# The env is shown when you run `terraform init && terraform workspace select {env}`

# include in PS1 variable
# example: PS1="$PS1\$(__terraform_ps1)\[$WHITE\]\$ "

__terraform_ps1 ()
{
    local exit=$?

    tf_dir=$(find . -maxdepth 1 -type d -name '.terraform')
    # get current workspace
    __TF_PROMPT_WORKSPACE_NAME=""

    if [ -d "$tf_dir" ] && [ -f "$tf_dir/environment" ]; then
      __TF_PROMPT_WORKSPACE_NAME=$(head -n 1 "$tf_dir/environment")
      if [ -n "${__TF_PROMPT_WORKSPACE_NAME}" ]; then
        echo -ne "${White}(tf-env: "
        echo -ne "${__TF_PROMPT_WORKSPACE_NAME}${White}${ResetColor}"
        shopt -s nocasematch
        if [[ "${__TF_PROMPT_WORKSPACE_NAME}" =~ ^prod.*|.*prod$ ]]; then
          echo -ne " 🚨 ) "
        else
          echo -ne ") "
        fi
      fi
    else
        __TF_PROMPT_WORKSPACE_NAME=""
        return $exit
    fi
}

