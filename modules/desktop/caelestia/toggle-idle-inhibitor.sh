#!/usr/bin/env bash
#
# Toggles caelestias idle inhibitor and sends a notification

if [ "$(caelestia-shell ipc call idleInhibitor isEnabled)" == "true" ]; then
  action="Disabled"
else
  action="Enabled"
fi

TITLE="Keep Awake"
MESSAGE="$action the idle inhibitor"
ICON="coffee"
caelestia-shell ipc call toaster info "$TITLE" "$MESSAGE" "$ICON"

caelestia-shell ipc call idleInhibitor toggle
