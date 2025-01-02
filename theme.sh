#!/usr/bin/env bash

base_dir="%PLACEHOLDER%" # DO NOT MODIFY
conf_file="${base_dir}/alacritty.toml"
theme_dir="${base_dir}/themes"

target_theme="$1"
scan_duration=${2:-0.5}
theme_file="${theme_dir}/${target_theme}.toml"

function get_current_theme {
  awk -F/ '/toml/ {
    print $NF
  }' <(cat "$conf_file") | sed -e 's/.toml//g' -e 's/\"//g'
}

function random_theme {
  find "$theme_dir" -type f -name "*.toml" \
  | shuf -n 1 | xargs basename -s '.toml'
}

current=$(get_current_theme)
echo "current theme: $current"

if [ "$target_theme" == "scan" ]; then
  if [ -n $ ]
  while true; do
    target_theme="$(random_theme)"
    sudo sed -i "s/$current/$target_theme/g" "$conf_file"
    echo -e "theme: $(get_current_theme)"
    ls -lrt --color=auto
    current=$(get_current_theme)
    sleep 0.5 && clear
  done
  exit
fi

if [ ! -f "$theme_file" ] && [ "$target_theme" != "random" ]; then
  [[ $# -gt 0 ]] && echo "Invalid theme."
  exit
fi

if [ "$target_theme" == "random" ]; then
    target_theme=$(random_theme)
fi

sudo sed -i "s/$current/${target_theme}/g" "$conf_file"
echo "new theme: $(get_current_theme)"
