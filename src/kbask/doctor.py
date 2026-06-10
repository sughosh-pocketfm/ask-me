"""`kbask doctor` — preflight check for upstream dependencies."""

from __future__ import annotations

from pathlib import Path

from kbask.installers.common import check_dependencies


def run(repo: Path) -> int:
    print(f"kbask doctor — repo: {repo}\n")
    status = check_dependencies(repo)
    bad = [k for k, v in status.items() if not v.get("ok")]
    print()
    if bad:
        print(f"missing or degraded: {', '.join(bad)}")
        return 1
    print("all upstreams ok")
    return 0
