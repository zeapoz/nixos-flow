#!/usr/bin/env bash
#
# Switches to the next power profile based on currently activated one, looping around at the end.

current=$(powerprofilesctl get)

case "$current" in
  "power-saver")
    powerprofilesctl set balanced
    profile="Balanced"
    icon="power-profile-balanced-symbolic"
    ;;
  "balanced")
    powerprofilesctl set performance
    profile="Performance"
    icon="power-profile-performance-symbolic"
    ;;
  "performance")
    powerprofilesctl set power-saver
    profile="Power Saver"
    icon="power-profile-power-saver-symbolic"
    ;;
esac

notify-send -u low -i "$icon" -e -a "Power Profile" "Power Profile" "Switching to ${profile} profile"
