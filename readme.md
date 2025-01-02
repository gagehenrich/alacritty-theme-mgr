# Alacritty Theme Manager

A lightweight and efficient command-line utility to manage and switch Alacritty themes with ease.

https://github.com/user-attachments/assets/26dda245-63e4-42c8-967b-2b641c86507b

## Features

- **Theme Switching**: Instantly switch between themes without manually editing configuration files.
- **Random Theme Selector**: Spice up your terminal by randomly applying a theme.
- **Theme Scanning**: Continuously scan and preview themes to find your perfect match.
- **WSL Compatibility**: Fully supports Windows Subsystem for Linux (WSL) for seamless integration.
- **Backup Mechanism**: Automatically backs up your existing configuration before making changes.

---

## Installation

### Prerequisites
- [Alacritty](https://github.com/alacritty/alacritty) installed on your system.
- Bash shell.
- Sudo (you will be prompted during installation)

### Steps
1. Clone this repository:
   ```bash
   git clone https://github.com/gagehenrich/alacritty-theme-mgr.git
   cd alacritty-theme-manager
   ```
2. Optional: configure `./alacritty.toml` to your desired configuration (but do not modify the theme import).
3. Run the `make` command:
   ```bash
   make install
   ```
4. Source autocomplete (also added to .bashrc).
   ```bash
   source $HOME/.config/alacritty/.autocomplete.sh
   ```

---

## Usage

### Commands

#### Switch to a Specific Theme
```bash
$ theme <theme-name>
```
Replace `<theme-name>` with the name of your desired theme.

#### Apply a Random Theme
```bash
$ theme random
```

#### Scan and Preview Themes
```bash
$ theme scan
```
Continuously switches themes every 0.5 seconds until interrupted (Ctrl+C).

- Optional: adjust scan duration (s):
```bash
$ theme scan 2
```
- Optional: adjust scan cmd: 
```bash
$ theme scan 1 pfetch
```
#### Get the Current Theme
```bash
$ theme
```
Displays the name of the currently active theme.

---

## Configuration

During installation, the script automatically sets up your Alacritty configuration directory based on your environment:

- **WSL**: Configuration is placed in `%AppData%/Roaming/alacritty`.
- **Linux**: Configuration is placed in `~/.config/alacritty`.

---

## Uninstallation

To uninstall the theme manager, run:
```bash
make uninstall
```
This removes the `theme` command from your system.

---

## Example

```bash
$ theme gruvbox
current theme: dracula
new theme: gruvbox

$ theme random
current theme: gruvbox
new theme: nord

$ theme scan
current theme: nord
theme: solarized_dark
theme: onedark
...
```

---

---

## License

This project is licensed under the [GPLv3 License](LICENSE).

---

## Acknowledgments

- Themes courtesy of https://github.com/alacritty/alacritty-theme
