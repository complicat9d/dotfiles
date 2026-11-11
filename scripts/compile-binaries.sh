#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$ROOT_DIR/templates/config/skhd/scripts"
BIN_DIR="$ROOT_DIR/templates/config/skhd/bin"

if ! xcode-select -p >/dev/null 2>&1; then
    echo "Command Line Tools not found — installing (confirm the dialog)…"
    xcode-select --install >/dev/null 2>&1 || true
    until xcode-select -p >/dev/null 2>&1; do sleep 5; done
    echo "Command Line Tools installed"
fi

shopt -s nullglob
sources=("$SRC_DIR"/*.swift)
[ ${#sources[@]} -gt 0 ] || { echo "no .swift files in $SRC_DIR" >&2; exit 1; }

mkdir -p "$BIN_DIR"

for src in "${sources[@]}"; do
    name="$(basename "$src" .swift)"
    echo "compiling $name"
    swiftc -O "$src" -o "$BIN_DIR/$name"
    codesign --force -s - "$BIN_DIR/$name"
done

echo "binaries installed to $BIN_DIR"