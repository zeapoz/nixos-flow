#!/usr/bin/env bash
#
# Switches to the next power profile based on currently activated one, looping around at the end.

current=$(powerprofilesctl get)

case "$current" in
  "power-saver")
    powerprofilesctl set balanced
    profile="Balanced"
    icon="balance"
    ;;
  "balanced")
    powerprofilesctl set performance
    profile="Performance"
    icon="rocket_launch"
    ;;
  "performance")
    powerprofilesctl set power-saver
    profile="Power Saver"
    icon="energy_savings_leaf"
    ;;
esac

TITLE="Power Profile"
MESSAGE="Switching to ${profile} profile"
caelestia-shell ipc call toaster info "$TITLE" "$MESSAGE" "$icon"
