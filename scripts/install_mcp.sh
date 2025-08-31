#!/usr/bin/env bash
#
# install_mcp.sh
#
# This script installs dependencies required to use Codex CLI with the
# configured MCP servers. It installs ripgrep and the Node packages
# necessary to launch MCP servers via npx. You can run this script from
# the root of the project with:
#
#   ./scripts/install_mcp.sh
#
# NOTE: You must have npm installed on your system. On Debian/Ubuntu you can
# install Node.js and npm via your package manager (e.g. `sudo apt install
# nodejs npm`).

set -euo pipefail

echo "[install_mcp] Installing dependencies for Codex MCP project..."

# Install ripgrep if not available. In many distros, ripgrep is packaged as
# `ripgrep` or `rg`. This attempts to install via apt if available.
if ! command -v rg >/dev/null 2>&1; then
  echo "[install_mcp] ripgrep not found. Attempting to install via apt..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y ripgrep
  else
    echo "[install_mcp] Please install ripgrep manually for your platform."
  fi
else
  echo "[install_mcp] ripgrep already installed."
fi

# Install Codex CLI globally
if ! command -v codex >/dev/null 2>&1; then
  echo "[install_mcp] Installing @openai/codex globally..."
  npm install -g @openai/codex
else
  echo "[install_mcp] codex CLI already installed."
fi

# Ensure that the MCP servers can be run by npx. This will download the
# packages into the npm cache on first run when Codex starts. No action
# needed here because npx fetches automatically. The packages are
# specified in `.codex/config.toml` and are resolved at runtime.

echo "[install_mcp] Installation complete."
