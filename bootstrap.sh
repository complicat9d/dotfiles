#!/bin/bash
PYTHON_VERSION=3.13

set -euo pipefail

if [[ ! -x /opt/homebrew/bin/brew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

brew install uv git

uv python install "$PYTHON_VERSION"
uv tool install \
    --python "$PYTHON_VERSION" \
    --with-executables-from ansible-core \
    ansible

export PATH="$(uv tool dir --bin):$PATH"

ansible-playbook --version