#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/../templates"

SETTINGS_SRC="$TEMPLATES_DIR/vscodium"
VSIX_DIR="${1:-$TEMPLATES_DIR/vscode-ext}"
USER_DIR="$HOME/Library/Application Support/VSCodium/User"

CODIUM="$(command -v codium || echo /Applications/VSCodium.app/Contents/Resources/app/bin/codium)"
[[ -x "$CODIUM" ]] || { echo "codium not found. Install VSCodium first." >&2; exit 1; }

mkdir -p "$USER_DIR"

for item in settings.json; do
    src="$SETTINGS_SRC/$item"
    dest="$USER_DIR/$item"
    [[ -e "$src" ]] || continue

    ln -sfn "$src" "$dest"
    echo "Linked $item"
done

arch="$(uname -m)"
shopt -s nullglob

for vsix in "$VSIX_DIR"/*.vsix; do
    name="$(basename "$vsix")"
    echo "Installing $name"
    "$CODIUM" --install-extension "$vsix" --force
done

echo "Installed extensions:"
"$CODIUM" --list-extensions --show-versions