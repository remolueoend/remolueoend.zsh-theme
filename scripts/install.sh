#!/usr/bin/env bash

PREZTO_DIR="${ZDOTDIR:-$HOME}/.zprezto"
THEME_DIR="${THEME_DIR:-$PREZTO_DIR/modules/prompt/functions}"
THEME_FILE="$THEME_DIR/prompt_remolueoend_setup"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "trying to install remolueoend under $THEME_DIR"
ln -sf "$SCRIPT_DIR/../remolueoend.zsh" "$THEME_FILE"

[ -e $THEME_FILE ] && echo "successfully installed" && exit 0 || echo "Failed to install" && exit 1
