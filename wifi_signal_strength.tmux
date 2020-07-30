#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/helpers.sh"

wifi_signal_strength_interpolation=(
	"\#{wifi_signal_strength}"
	"\#{wifi_signal_strength_bg}"
	"\#{wifi_signal_strength_fg}"
  "\#{wifi_signal_strength_icon}"
)

wifi_signal_strength_commands=(
	"#($CURRENT_DIR/scripts/wifi_signal_strength.sh)"
	"#($CURRENT_DIR/scripts/wifi_signal_strength_bg.sh)"
	"#($CURRENT_DIR/scripts/wifi_signal_strength_fg.sh)"
	"#($CURRENT_DIR/scripts/wifi_signal_strength_icon.sh)"
)

interpolate() {
  local status_bar="$1"

  for ((i=0; i<${#wifi_signal_strength_commands[@]}; i++)); do
    local interpolation="${wifi_signal_strength_interpolation[$i]}"
    local command="${wifi_signal_strength_commands[$i]}"

    status_bar=${status_bar//$interpolation/$command}
  done

  echo "$status_bar"
}

update_status_bar() {
  local side="$1"

  local option_name="status-$side"
  local option_value="$(tmux show-option -gqv "$option_name")"
  local next_option_value="$(interpolate "$option_value")"

  tmux set-option -gq "$option_name" "$next_option_value"
}

set_option_defaults() {
  set_tmux_option "$wifi_signal_strength_high_msg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_medium_msg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_low_msg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_off_msg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_high_bg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_medium_bg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_low_bg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_off_bg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_high_fg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_medium_fg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_low_fg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_off_fg_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_high_icon_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_medium_icon_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_low_icon_option" "__wifi_signal_strength_default__"
  set_tmux_option "$wifi_signal_strength_off_icon_option" "__wifi_signal_strength_default__"
}

main() {
  set_option_defaults

	update_status_bar "left"
  update_status_bar "right"
}

main
