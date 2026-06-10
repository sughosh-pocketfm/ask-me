#!/usr/bin/env python3
"""Thin trampoline → `askme install agy` (placeholder)."""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "src"))

from askme.install import run

if __name__ == "__main__":
    sys.exit(run("agy", extra_args=sys.argv[1:]))
