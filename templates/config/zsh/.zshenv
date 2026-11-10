# --- XDG base directories ---
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
# macOS has no /run/user/$UID; $TMPDIR is per-user and private (0700)
export XDG_RUNTIME_DIR="${TMPDIR:-/tmp}"
