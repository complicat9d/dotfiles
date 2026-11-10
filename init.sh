#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

scripts=(
  install-brew.sh
  compile-binaries.sh
  init-configs.sh
  install-vsix.sh
  confgiure-finder.sh
)

for script in "${scripts[@]}"; do
  echo "Executing $script..."
  bash "$ROOT_DIR/scripts/$script"
done

echo "Finished initialization."