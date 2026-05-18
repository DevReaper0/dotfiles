#!/bin/bash

selection="$(
  {
    printf '%s\n' 'Disable'
    hyprgroups substitute available
  } | rofi -dmenu -i -p "Substitute"
)"

case "$selection" in
"")
  exit 0
  ;;
"Disable")
  hyprgroups substitute disable
  ;;
*)
  hyprgroups substitute set "$selection"
  ;;
esac
