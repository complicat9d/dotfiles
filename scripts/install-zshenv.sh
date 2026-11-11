#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/../templates/etc/zshenv"

if cmp -s "$SRC" /etc/zshenv; then
    echo "/etc/zshenv already up to date"
else
    sudo cp "$SRC" /etc/zshenv
    echo "Installed /etc/zshenv"
fi