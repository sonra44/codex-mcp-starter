#!/usr/bin/env bash
#
# run_codex.sh
#
# Launches the Codex CLI with the project’s configuration. This script
# changes into the root of the repository, ensures the `.codex` directory
# exists, and then launches Codex. By default, Codex runs in Auto mode
# which allows reading and writing files inside the repository with
# confirmations before executing commands or network access. You can
# override the default mode by passing flags (see `codex --help`).

set -euo pipefail

# Use project root as working directory
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_ROOT=$(dirname "$SCRIPT_DIR")
cd "$PROJECT_ROOT"

echo "[run_codex] Starting Codex CLI with project configuration..."

# Launch codex specifying the config path. The CLI will automatically
# discover `.codex/config.toml` but passing it explicitly avoids confusion.
codex --config "${PROJECT_ROOT}/.codex/config.toml"
