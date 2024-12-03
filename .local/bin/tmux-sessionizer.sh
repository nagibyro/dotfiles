#!/usr/bin/env bash

###
# based off of https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
# With some of my added workflow customization namely starting tmux with a
# poetry shell if is a python poetry project. As well as starting 2 windows one
# for nvim editor and the other for terminal
###

is_poetry_project () {
  local dir=$1

  if [[ -f "$dir/poetry.lock" ]]; then
    return 0
  fi

  return 1
}

workspace_setup () {
  session_name=$1
  workspace_dir=$2


  tmux rename-window -t "$session_name":1 "nvim"
  tmux new-window -t "$session_name" -n 'shell' -c "$workspace_dir"

  if is_poetry_project "$workspace_dir"; then
    local poetry_venv_path=$(cd "$workspace_dir" && poetry env info --path)

    tmux list-windows -t "$session_name" -F '#I' | while read -r window_id; do
      tmux send-keys -t "${session_name}":"${window_id}" "source $poetry_venv_path/bin/activate" C-m 'clear' C-m
    done
  fi

  tmux send-keys -t "$session_name":nvim "nvim ." C-m
}

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/projects/work ~/projects/personal ~/ -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
is_new=1

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -ds "$selected_name" -c "$selected"
  is_new=0
elif ! tmux has-session -t="$selected_name" 2> /dev/null; then
  tmux new-session -ds "$selected_name" -c "$selected"
  is_new=0
fi


if [[ $is_new -eq 0 ]]; then
  workspace_setup "$selected_name" "$selected"
fi

if [[ -z $TMUX ]]; then
  tmux attach-session -t "$selected_name":1
else
  tmux switch-client -t "$selected_name":1
fi

