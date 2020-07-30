# Tmux Wifi Signal Strength

Enables displaying transmit rate value and status icon in tmux status line.

## TPM Installation

Add plugin to the list of TPM plugins in `.tmux.conf`:

```
set -g @plugin 'sleekybadger/tmux-wifi-signal-strength'
```

Hit `prefix + I` to fetch the plugin and source it.

If format strings are added to `status-left` or `status-right`, they should be visible now.

## Manual Installation

Clone the repo:

```
$ git clone git@github.com:sleekybadger/tmux-wifi-signal-strength.git ~/clone/path
```

Add this line to the bottom of `.tmux.conf`:

```
run-shell ~/clone/path/wifi_signal_strength.tmux
```

Reload TMUX environment:

```
$ tmux source-file ~/.tmux.conf
```

If format strings are added to `status-left` or `status-right`, they should now be visible.

## Usage

Add `#{wifi_signal_strength}`, `#{wifi_signal_strength_bg}` `#{wifi_signal_strength_fg}`, or
`#{wifi_signal_strength_icon}` format strings to `status-left` or `status-right` tmux options.

Example:

```
set -g status-right "#{wifi_signal_strength_icon} #{wifi_signal_strength}"
```

## Examples

Signal strength low:<br />
![signal strength low](/screenshots/wifi_signal_strength_high.png)

Signal strength medium:<br />
![signal strength medium](/screenshots/wifi_signal_strength_medium.png)

Signal strength high:<br />
![signal strength high](/screenshots/wifi_signal_strength_low.png)

Signal absent:<br />
![signal absent](/screenshots/wifi_signal_strength_off.png)

This is done by introducing new format strings that can be added to status options:
- `#{wifi_signal_strength}` - will display transmit rate value
- `#{wifi_signal_strength_icon}` - will show a icon
- `#{wifi_signal_strength_bg}` - will set the background color of the status bar based on the transmit rate value
- `#{wifi_signal_strength_fg}` - will set the foreground color of the status bar based on the transmit rate value

## Customization

By default, these values are used:

| Option                            | Value.        | Description                                              |
| --------------------------------- | :-----------: | -------------------------------------------------------- |
| @wifi_signal_strength_high_msg    | #{rate} Mb/s  | Used to display rate when rate >= 200                    |
| @wifi_signal_strength_medium_msg  | #{rate} Mb/s  | Used to display rate when rate >= 100 && rate < 200      |
| @wifi_signal_strength_low_msg     | #{rate} Mb/s  | Used to display rate when rate > 0 && rate < 100         |
| @wifi_signal_strength_off_msg     | Off           | Used to display rate when rate == 0                      |
| @wifi_signal_strength_high_bg     | colour015     | Used for background color when rate >= 200               |
| @wifi_signal_strength_medium_bg   | colour015     | Used for background color when rate >= 100 && rate < 200 |
| @wifi_signal_strength_low_bg      | colour015     | Used for background color when rate > 0 && rate < 100    |
| @wifi_signal_strength_off_bg      | colour015     | Used for background color when rate == 0                 |
| @wifi_signal_strength_high_fg     | colour034     | Used for foreground color when rate >= 200               |
| @wifi_signal_strength_medium_fg   | colour202     | Used for foreground color when rate >= 100 && rate < 200 |
| @wifi_signal_strength_low_fg      | colour196     | Used for foreground color when rate > 0 && rate < 100    |
| @wifi_signal_strength_off_fg      | colour000     | Used for foreground color when rate == 0                 |
| @wifi_signal_strength_high_icon   | █             | Used for status icon when rate >= 200                    |
| @wifi_signal_strength_medium_icon | ▆             | Used for status icon when rate >= 100 && rate < 200      |
| @wifi_signal_strength_low_icon    | ▄             | Used for status icon when rate > 0 && rate < 100         |
| @wifi_signal_strength_off_icon    |               | Used for status icon when rate == 0                      |

You can change these defaults by adding the following to `.tmux.conf`:

```
set -g @wifi_signal_strength_high_msg "Hello world #{rate}"
set -g @wifi_signal_strength_low_bg "colour000"
set -g @wifi_signal_strength_medium_fg "colour201"
set -g @wifi_signal_strength_off_icon "⮃"
```

Don't forget to reload tmux environment after you do this:

```
$ tmux source-file ~/.tmux.conf
```

## History

See [changelog](CHANGELOG.md).

## Contributing

See [contribution guidelines](CONTRIBUTING.md).

## License

Tmux Wifi Signal Strength is released under the [MIT](LICENSE.md) license.
