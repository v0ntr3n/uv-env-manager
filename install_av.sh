#!/usr/bin/env bash
set -euo pipefail

REPO="v0ntr3n/uv-env-manager"
BRANCH="main"
RAW="https://raw.githubusercontent.com/$REPO/$BRANCH"

echo "================================="
echo " uv-env-manager installer"
echo "================================="
echo

# curl is required because this installer itself is normally launched with curl.
if ! command -v curl >/dev/null 2>&1; then
    echo "[!] curl is required."
    exit 1
fi

# -------------------------------------------------------
# Install uv
# -------------------------------------------------------

if ! command -v uv >/dev/null 2>&1; then
    echo "==> Installing uv..."

    curl -LsSf https://astral.sh/uv/install.sh | sh

    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
else
    echo "==> uv already installed"
fi

if ! command -v uv >/dev/null 2>&1; then
    echo "[!] uv installation failed or uv is not on PATH."
    exit 1
fi

echo "==> $(uv --version)"

# -------------------------------------------------------
# Choose installation directory
# -------------------------------------------------------

if [[ "$(id -u)" -eq 0 ]]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
fi

echo "==> Installing av to $INSTALL_DIR/av"

# -------------------------------------------------------
# Download av
# -------------------------------------------------------

TMP_FILE="$(mktemp)"

cleanup() {
    rm -f "$TMP_FILE"
}

trap cleanup EXIT

curl -fsSL "$RAW/av" -o "$TMP_FILE"

chmod +x "$TMP_FILE"
install -m 0755 "$TMP_FILE" "$INSTALL_DIR/av"

# -------------------------------------------------------
# Environment storage
# -------------------------------------------------------

ENV_ROOT="${AV_ENV_ROOT:-$HOME/.local/share/uv_venv}"
mkdir -p "$ENV_ROOT"

# -------------------------------------------------------
# PATH
# -------------------------------------------------------

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo
    echo "==> Adding $INSTALL_DIR to PATH"

    if [[ -f "$HOME/.bashrc" ]]; then
        if ! grep -qF "$INSTALL_DIR" "$HOME/.bashrc"; then
            echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.bashrc"
        fi
    fi

    export PATH="$INSTALL_DIR:$PATH"
fi

echo
echo "================================="
echo " Installation complete"
echo "================================="
echo
echo "av:      $INSTALL_DIR/av"
echo "envs:    $ENV_ROOT"
echo "uv:      $(command -v uv)"
echo
echo "Run:"
echo
echo "    av"
echo