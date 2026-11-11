#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ETC_DIR="$ROOT_DIR/templates/etc"
CONFIG_DIR="$ROOT_DIR/templates/config"
DEST="$HOME/.config"

mkdir -p "$DEST"
shopt -s nullglob

for src in "$CONFIG_DIR"/*; do
    name="$(basename "$src")"
    dest="$DEST/$name"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        rm -rf "$dest"
    fi

    ln -sfn "$src" "$dest"
    echo "Linked $name" "$dest"
done