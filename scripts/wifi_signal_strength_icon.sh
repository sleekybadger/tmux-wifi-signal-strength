#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/helpers.sh"

print_wifi_signal_strength_icon() {
  local tx_rate="$(get_tx_rate)"

  if [ $tx_rate -gt 200 ]; then
    echo $(get_tmux_option "$wifi_signal_strength_high_icon_option" "$wifi_signal_strength_high_icon_default")
  elif [ $tx_rate -gt 100 ]; then
    echo $(get_tmux_option "$wifi_signal_strength_medium_icon_option" "$wifi_signal_strength_medium_icon_default")
  elif [ $tx_rate -gt 0 ]; then
    echo $(get_tmux_option "$wifi_signal_strength_low_icon_option" "$wifi_signal_strength_low_icon_default")
  elif [ $tx_rate == 0 ]; then
    echo $(get_tmux_option "$wifi_signal_strength_off_icon_option" "$wifi_signal_strength_off_icon_default")
  fi
}

main() {
  print_wifi_signal_strength_icon
}

main
