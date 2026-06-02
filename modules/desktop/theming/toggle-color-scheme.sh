#!/usr/bin/env bash
# Toggles between dark and light mode.

KEY=/org/gnome/desktop/interface/color-scheme

current=$(dconf read "$KEY")
if [ "$current" = "'prefer-light'" ]; then
  mode=dark
  icon="dark_mode"
  dconf write "$KEY" "'prefer-dark'"
  dconf write /org/gnome/desktop/interface/gtk-theme "'Orchis-Purple-Dark'"
  dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Dark'"
else
  mode=light
  icon="light_mode"
  dconf write "$KEY" "'prefer-light'"
  dconf write /org/gnome/desktop/interface/gtk-theme "'Orchis-Purple-Light'"
  dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Light'"
fi

TITLE="Color Scheme"
MESSAGE="Set to $mode mode"
caelestia-shell ipc call toaster info "$TITLE" "$MESSAGE" "$icon"
