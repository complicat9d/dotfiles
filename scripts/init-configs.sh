#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ETC_DIR="$SCRIPT_DIR/../templates/etc"
CONFIG_DIR="$SCRIPT_DIR/../templates/config"

sudo cp "$ETC_DIR/zshenv" /etc/zshenv

mkdir -p ~/.config
cp -R "$CONFIG_DIR/." ~/.config/