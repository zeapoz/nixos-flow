#!/usr/bin/env bash
#
#

DEVICE_NAME="asustek-computer-inc.-gz302ea-keyboard-touchpad"

# Hyprctl getoption is not able to query the status directly, so we use a status file.
STATUS_FILE="$HOME/.touchpad.status"

# Toggles the touchpad.
function toggle() {
  if [ "$(cat "$STATUS_FILE")" = "false" ]; then
    echo "true" >"$STATUS_FILE"
    action="Enabled"
    icon="touchpad-enabled-symbolic"
  else
    echo "false" >"$STATUS_FILE"
    action="Disabled"
    icon="touchpad-disabled-symbolic"
  fi

  notify-send -u low -i "$icon" -e -a "Touchpad" "Touchpad" "$action the touchpad"
  hyprctl keyword device["$DEVICE_NAME"]:enabled "$(cat "$STATUS_FILE")"
}

# Gets the current state of the touchpad.
function get() {
  if [ "$(cat "$STATUS_FILE")" = "false" ]; then
    state="disabled"
    icon="touchpad-disabled-symbolic"
  else
    state="enabled"
    icon="touchpad-enabled-symbolic"
  fi

  notify-send -u low -i "$icon" -e -a "Touchpad" "Touchpad" "The touchpad is currently $state"
}

# Sets the touchpad state based on the status file.
function update() {
  get
  hyprctl keyword device["$DEVICE_NAME"]:enabled "$(cat "$STATUS_FILE")"
}

function main() {
  case "$1" in
    --toggle)
      toggle
      ;;
    --update)
      update
      ;;
    --get)
      get
      ;;
    *)
      echo "Usage: ${0##*/} [--toggle|--update|--get]"
      ;;
  esac
}

main "$@"
