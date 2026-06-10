#!/usr/bin/env bash
# askme-mcp one-line installer.
#
# Public repo:
#   curl -fsSL https://raw.githubusercontent.com/sughosh-pocketfm/ask-me/main/install.sh | bash -s claude
#
# Private repo (uses your gh CLI auth):
#   gh api repos/sughosh-pocketfm/ask-me/contents/install.sh -H "Accept: application/vnd.github.raw" | bash -s claude
#
# Args:
#   $1  host  one of: claude | codex | gemini | agy   (default: claude)
#   $@  extra flags forwarded to `askme install <host>` (e.g. --dry-run)
#
# Env:
#   ASKME_SOURCE  override the uvx --from value (default: this git repo).
#   ASKME_REPO    target repo to install into (default: $PWD).

set -euo pipefail

HOST="${1:-claude}"
shift || true

SOURCE="${ASKME_SOURCE:-git+https://github.com/sughosh-pocketfm/ask-me}"
REPO="${ASKME_REPO:-$(pwd)}"

say() { printf '[askme-install] %s\n' "$*" >&2; }

# 1. Ensure git can authenticate to GitHub (for private askme repo).
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  gh auth setup-git >/dev/null 2>&1 || true
  say "git credential helper configured via gh"
fi

# 2. Ensure uvx is on PATH.
if ! command -v uvx >/dev/null 2>&1; then
  say "uv not found; installing via astral installer"
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# 3. Dispatch to askme install.
say "uvx --from $SOURCE askme install $HOST --repo $REPO $*"
exec uvx --from "$SOURCE" askme install "$HOST" --repo "$REPO" "$@"
