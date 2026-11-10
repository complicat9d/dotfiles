# dotfiles

The repository for fast OSX initialization, relevant apps for a better workflow management.

Run one script on a fresh Mac and get the Homebrew apps installed, configs in place, editor extensions loaded, and a keyboard-driven tiling setup with yabai and skhd.

For my experience with the apps in this setup, and the alternatives I tried, see [APPS.md](APPS.md).

## Environment

This configuration was built and tested on **macOS Sequoia**.

yabai needs System Integrity Protection disabled to load its scripting addition — see the [yabai wiki](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection). On Sequoia, newer yabai releases have an issue initializing, so this setup uses **yabai v7.1.16**.

## Quick start

```bash
git clone <repo-url> dotfiles
cd dotfiles
./init.sh
```

`init.sh` runs the setup steps below. Each script can also be run on its own.

## What it does

| Script | What it does |
|---|---|
| `scripts/install-brew.sh` | Installs Homebrew and everything in `templates/Brewfile` |
| `scripts/init-configs.sh` | Copies `templates/etc/zshenv` to `/etc/zshenv` and `templates/config/` into `~/.config/` |
| `scripts/compile-binaries.sh` | Installs the Xcode Command Line Tools if missing, then compiles every `.swift` file in `templates/config/skhd/scripts/` into `~/.config/skhd/bin/` and ad-hoc signs it |
| `scripts/install-vsix.sh` | Installs the bundled editor extensions from `templates/vscode-ext/` |

> **Note:** `init-configs.sh` overwrites files in `~/.config/` with the versions from this repo. Back up anything you want to keep first.

## Layout

```
templates/
├── Brewfile           # Homebrew packages, casks and apps
├── etc/zshenv         # system-wide zsh environment
├── config/            # copied to ~/.config
│   ├── ghostty/       # terminal
│   ├── nvim/          # Neovim (lazy.nvim, obsidian.nvim)
│   ├── skhd/          # hotkeys + Swift helper sources
│   ├── yabai/         # tiling window manager
│   ├── zsh/
│   └── starship.toml  # prompt
└── vscode-ext/        # .vsix extensions (theme, Ruff, basedpyright, Codeium, Data Wrangler)
```

## Window management

Windows are managed by [yabai](https://github.com/koekeishiya/yabai), and hotkeys are handled by [skhd-zig](https://github.com/jackielii/skhd.zig). Two small Swift helpers do what yabai alone can't do reliably:

- **`toggle_app <bundle-id>`** shows, hides, or launches an app. If the app is frontmost it hides it; otherwise it launches or reopens it, so the app's window actually comes forward. This also works for Finder with no open windows.
- **`fs_ax`** makes the focused window fill its screen. It uses the macOS Accessibility API directly instead of yabai's `windowed-fullscreen` flag, which gets out of sync when a window is resized by another command.

## Permissions

After the first run, grant **Accessibility** access under System Settings → Privacy & Security → Accessibility to:

- **skhd**, so hotkeys work
- **yabai**, so it can manage windows
- **`~/.config/skhd/bin/fs_ax`**, if it doesn't work from the hotkey. Usually skhd's permission covers it.

Rebuilding a helper changes its ad-hoc signature, so macOS may ask for its permission again after `compile-binaries.sh` runs.