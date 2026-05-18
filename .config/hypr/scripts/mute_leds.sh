#!/bin/bash

update_mute() {
  if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
    brightnessctl --device 'platform::mute' set 1
  else
    brightnessctl --device 'platform::mute' set 0
  fi
}

update_mic_mute() {
  if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q "yes"; then
    brightnessctl --device 'platform::micmute' set 1
  else
    brightnessctl --device 'platform::micmute' set 0
  fi
}

update_mute
update_mic_mute

pactl subscribe | while read -r event; do
  if [[ "$event" == *" on sink"* ]]; then
    update_mute
  elif [[ "$event" == *" on source"* ]]; then
    update_mic_mute
  fi
done
