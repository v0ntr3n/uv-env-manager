#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
AV_SOURCE="$SCRIPT_DIR/av"

if [[ ! -f "$AV_SOURCE" ]]; then
    echo "Error: 'av' must be in the same directory as this installer." >&2
    exit 1
fi

echo "==> Installing prerequisites..."
if command -v apt-get >/dev/null 2>&1; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y curl ca-certificates
fi

if ! command -v uv >/dev/null 2>&1; then
    echo "==> Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # uv's installer normally uses ~/.local/bin.
    export PATH="$HOME/.local/bin:$PATH"
fi

if ! command -v uv >/dev/null 2>&1; then
    echo "Error: uv was installed but is not currently on PATH." >&2
    echo "Add \$HOME/.local/bin to PATH and rerun this installer." >&2
    exit 1
fi

echo "==> uv: $(uv --version)"

# When installing as root, make uv available system-wide as well.
if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    UV_BIN="$(command -v uv)"
    if [[ "$UV_BIN" != "/usr/local/bin/uv" ]]; then
        install -m 0755 "$UV_BIN" /usr/local/bin/uv
    fi
    if command -v uvx >/dev/null 2>&1; then
        UVX_BIN="$(command -v uvx)"
        if [[ "$UVX_BIN" != "/usr/local/bin/uvx" ]]; then
            install -m 0755 "$UVX_BIN" /usr/local/bin/uvx
        fi
    fi
fi

# System-wide installation when root; user-local otherwise.
if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
fi

echo "==> Installing av to $INSTALL_DIR/av"
install -m 0755 "$AV_SOURCE" "$INSTALL_DIR/av"

ENV_ROOT="${AV_ENV_ROOT:-$HOME/.local/share/uv_venv}"
mkdir -p "$ENV_ROOT"

echo
echo "Installed successfully."
echo "  av command: $INSTALL_DIR/av"
echo "  env root:   $ENV_ROOT"
echo
echo "Run:"
echo "  av"
echo
echo "If '$INSTALL_DIR' is not on PATH, add this to ~/.bashrc:"
echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
