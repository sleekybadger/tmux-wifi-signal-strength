#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/helpers.sh"

interpolate() {
  local message="$1"
  local value="$2"

  echo "${message//"\#{rate}"/$value}"
}

print_wifi_signal_strength() {
  local tx_rate="$(get_tx_rate)"
  local message

  if [ $tx_rate -gt 200 ]; then
    message="$(get_tmux_option "$wifi_signal_strength_high_msg_option" "$wifi_signal_strength_high_msg_default")"
  elif [ $tx_rate -gt 100 ]; then
    message="$(get_tmux_option "$wifi_signal_strength_medium_msg_option" "$wifi_signal_strength_medium_msg_default")"
  elif [ $tx_rate -gt 0 ]; then
    message="$(get_tmux_option "$wifi_signal_strength_low_msg_option" "$wifi_signal_strength_low_msg_default")"
  elif [ $tx_rate == 0 ]; then
    message="$(get_tmux_option "$wifi_signal_strength_off_msg_option" "$wifi_signal_strength_off_msg_default")"
  fi

  echo "$(interpolate "$message" "$tx_rate")"
}

main() {
  print_wifi_signal_strength
}

main
