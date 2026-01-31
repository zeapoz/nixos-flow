#!/usr/bin/env bash
#
# Toggles between dark and light mode.

KEY=/org/gnome/desktop/interface/color-scheme

current=$(dconf read "$KEY")
if [ "$current" = "'prefer-light'" ]; then
  mode=dark
  icon="weather-clear-night-symbolic"
  dconf write "$KEY" "'prefer-dark'"
else
  mode=light
  icon="weather-clear-symbolic"
  dconf write "$KEY" "'prefer-light'"
fi

notify-send -u low -i "$icon" -e -a "Theme" "Color Scheme" "Set to $mode mode"
