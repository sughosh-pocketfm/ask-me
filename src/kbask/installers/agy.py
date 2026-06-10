"""AGY installer placeholder. Config path / format not yet documented."""

from __future__ import annotations

import argparse
import sys


def add_arguments(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("--repo", default=".", help="Unused; placeholder.")
    parser.add_argument("--dry-run", action="store_true")


def main(args: argparse.Namespace) -> int:
    print(
        "AGY installer not yet implemented. The config path and format are not "
        "documented in this project. See "
        "https://github.com/sughosh-pocketfm/ask-me/issues for status.",
        file=sys.stderr,
    )
    return 2
