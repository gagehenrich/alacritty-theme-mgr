#!/usr/bin/env bash

theme_dir="%PLACEHOLDER%/themes/" # DO NOT MODIFY

_theme_autocomplete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local themes
    themes=$(for theme in "$theme_dir"/*.toml; do basename "$theme" .toml; done)
    COMPREPLY=($(compgen -W "$themes" -- "$cur"))
}

complete -F _theme_autocomplete theme
