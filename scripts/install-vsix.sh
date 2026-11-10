#!/usr/bin/env bash
set -euo pipefail

VSIX_DIR="${1:-./extensions}"

CODIUM="$(command -v codium || echo /Applications/VSCodium.app/Contents/Resources/app/bin/codium)"
[[ -x "$CODIUM" ]] || { echo "codium not found. Install VSCodium first."; exit 1; }

shopt -s nullglob
for vsix in "$VSIX_DIR"/*.vsix; do
  echo "Installing $(basename "$vsix")"
  "$CODIUM" --install-extension "$vsix" --force
done

echo "Installed extensions:"
"$CODIUM" --list-extensions --show-versions