#!/usr/bin/env bash
#
# Toggles the VPN connection on and off.

status=$(mullvad status --json | jq .state)
if [ "$status" = "\"disconnected"\" ]; then
  mullvad connect
else
  mullvad disconnect
fi
