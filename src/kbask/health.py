"""`kbask health` — report backend versions and graph freshness."""

from __future__ import annotations

import json
from pathlib import Path

from kbask import __version__, state
from kbask.backends import graphify, understand
from kbask.meta import load


def run() -> int:
    out_dir = Path("kbask-out").resolve()
    state.set_out_dir(out_dir)
    meta = load(out_dir / "meta.json")
    report = {
        "kbask_version": __version__,
        "graphify_version": graphify.version(),
        "understand_version": understand.version(),
        "kbask_out": str(out_dir),
        "kbask_out_exists": out_dir.exists(),
        "graph_json_exists": (out_dir / "graph.json").exists(),
        "knowledge_graph_exists": (out_dir / "knowledge-graph.json").exists(),
        "last_built_at": meta.built_at or None,
        "last_git_sha": meta.git_sha or None,
        "tracked_files": len(meta.files),
    }
    print(json.dumps(report, indent=2))
    return 0
