#!/usr/bin/env bash
#
# Utilities for controlling the touchpad, including toggling it on and off.

DEVICE_NAME="asustek-computer-inc.-gz302ea-keyboard-touchpad"

# Hyprctl getoption is not able to query the status directly, so we use a status file.
STATUS_FILE="$HOME/.touchpad.status"

# Caelestia toast config.
TITLE="Touchpad"

# Toggles the touchpad.
function toggle() {
  if [ "$(cat "$STATUS_FILE")" = "false" ]; then
    echo "true" >"$STATUS_FILE"
    action="Enabled"
    icon="touchpad_mouse"
  else
    echo "false" >"$STATUS_FILE"
    action="Disabled"
    icon="touchpad_mouse_off"
  fi

  caelestia-shell ipc call toaster info "$TITLE" "$action the touchpad" "$icon"
  hyprctl keyword device["$DEVICE_NAME"]:enabled "$(cat "$STATUS_FILE")"
}

# Gets the current state of the touchpad.
function get() {
  if [ "$(cat "$STATUS_FILE")" = "false" ]; then
    state="disabled"
    icon="touchpad_mouse_off"
  else
    state="enabled"
    icon="touchpad_mouse"
  fi

  caelestia-shell ipc call toaster info "$TITLE" "The touchpad is currently $state" "$icon"
  printf "%s\n" "$state"
}

# Sets the touchpad state based on the status file.
function update() {
  get
  hyprctl keyword device["$DEVICE_NAME"]:enabled "$(cat "$STATUS_FILE")"
}

function main() {
  case "$1" in
    toggle)
      toggle
      ;;
    update)
      update
      ;;
    get)
      get
      ;;
    *)
      printf "Usage: %s [toggle|update|get]\n" "${0##*/}" >&2
      ;;
  esac
}

main "$@"
