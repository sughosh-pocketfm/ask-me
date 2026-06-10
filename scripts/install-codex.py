#!/usr/bin/env python3
"""Thin trampoline → `kbask install codex`. Use the kbask CLI directly when possible."""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "src"))

from kbask.install import run

if __name__ == "__main__":
    sys.exit(run("codex", extra_args=sys.argv[1:]))
