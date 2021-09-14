#!/usr/bin/env sh

PREZTO_DIR="${ZDOTDIR:-$HOME}/.zprezto"
THEME_DIR="${THEME_DIR:-$PREZTO_DIR/modules/prompt/functions}"
THEME_FILE="$THEME_DIR/prompt_remolueoend_setup"

echo "trying to uninstall remolueoend under $THEME_FILE"

if ! [ -L $THEME_FILE ]; then
  echo "Theme remolueoend is not installed." && exit 1
fi

rm -f $THEME_FILE && echo "remolueoend successfully uninstalled."
