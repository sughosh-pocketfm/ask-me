#!/usr/bin/env python3
"""Thin trampoline → `askme install claude`. Use the askme CLI directly when possible."""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "src"))

from askme.install import run

if __name__ == "__main__":
    sys.exit(run("claude", extra_args=sys.argv[1:]))
