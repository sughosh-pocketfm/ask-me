#!/usr/bin/env bash
# kbask one-line installer.
#
# Public repo:
#   curl -fsSL https://raw.githubusercontent.com/sughosh-pocketfm/kbask/main/install.sh | bash -s claude
#
# Private repo (uses your gh CLI auth):
#   gh api repos/sughosh-pocketfm/kbask/contents/install.sh -H "Accept: application/vnd.github.raw" | bash -s claude
#
# Args:
#   $1  host  one of: claude | codex | gemini | agy   (default: claude)
#   $@  extra flags forwarded to `kbask install <host>` (e.g. --dry-run)
#
# Env:
#   KBASK_SOURCE  override the uvx --from value (default: this git repo).
#   KBASK_REPO    target repo to install into (default: $PWD).

set -euo pipefail

HOST="${1:-claude}"
shift || true

SOURCE="${KBASK_SOURCE:-kbask}"
REPO="${KBASK_REPO:-$(pwd)}"

say() { printf '[kbask-install] %s\n' "$*" >&2; }

# 1. Ensure git can authenticate to GitHub (for private kbask repo).
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

# 3. Dispatch to kbask install.
say "uvx --from $SOURCE kbask install $HOST --repo $REPO $*"
exec uvx --from "$SOURCE" kbask install "$HOST" --repo "$REPO" "$@"
