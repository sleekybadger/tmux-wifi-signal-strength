set_tmux_option() {
  local option="$1"
  local value="$2"

  echo "$option"
  echo "$value"

  tmux set-option -gqo "$option" "$value"
}

get_tmux_option() {
  local option="$1"
  local default_value="$2"

  local option_value="$(tmux show-option -gqv "$option")"
  if [ "$option_value" = "__wifi_signal_strength_default__" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

is_osx() {
  [ $(uname) == "Darwin" ]
}

get_tx_rate_from_airport() {
  local wireless_info="$(airport -I | grep "lastTxRate" | sed "s/.*: //")"

  if [ -z "$wireless_info" ]; then
    echo "0"
  else
    echo $wireless_info
  fi
}

get_tx_rate() {
  if is_osx; then
    get_tx_rate_from_airport
  fi
}
