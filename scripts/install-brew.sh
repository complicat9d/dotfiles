#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/../templates/Brewfile"

find_brew() {
    local candidate
    for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        if [[ -x "$candidate" ]]; then
            echo "$candidate"
            return 0
        fi
    done
    return 1
}

BREW="$(find_brew)" || { echo "Homebrew not found. Install it first: https://brew.sh" >&2; exit 1; }

eval "$("$BREW" shellenv)"

brew bundle install --file="$BREWFILE"