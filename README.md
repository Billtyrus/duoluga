# Duoluga Project – Canonical Entry Point

This repository is the **directory of record** for the Duoluga translation platform.  
Source code, documentation, and backups live in dated snapshots outside the repo; use this guide to land on the right version.

## Current Canonical Snapshot (2025-11-04)

- **Windows root**: `C:\Users\billt\OneDrive\Projects\backups\2025-10-23_V1.4.0_HYBRID_ROUTING_A\`
- **Linux/Docker mirror**: `/projects/duoluga/` (also mounted as `/mnt/AgentO/projects/duoluga/`)
- **Key docs** (paths relative to the snapshot root; swap the prefix for container paths when inside Docker):
  - Project scope & onboarding: `documentation/DUOLUGA_PROJECT_SCOPE.md`
  - Architecture (RAG bridge): `documentation/DUOLUGA_RAG_LOOKUP_BRIDGE.md`
  - Release notes: `documentation/DUOLUGA_V1_RELEASE_NOTES.md`
  - Latest session log: `documentation/SESSION_2025-10-19_DUOLUGA_RAG_COMPLETE.md`
  - Backup manifest: `documentation/BACKUP_MANIFEST.md`
  - API entry point: `scripts/duoluga_api.py`
  - Lookup middleware: `scripts/lookup_bridge.py`
  - Translation memories: `memory/translations_clean.jsonl`, `memory/duoluga_word_memory_clean.jsonl`
- **Support tooling**:
  - n8n fallback workflow and import helper: see `infrastructure/n8n/README.md` in this repository (covers credentials, import script, and logging paths)

For machine-readable pointers, check [`canonical_index.json`](canonical_index.json).
For a human-readable overview, see [`CANONICAL_SUMMARY.md`](CANONICAL_SUMMARY.md).

## How to Get Up to Date Quickly

1. Read `DUOLUGA_PROJECT_SCOPE.md` for status, recovery procedures, and roadmap.
2. Review `SESSION_2025-10-19_DUOLUGA_RAG_COMPLETE.md` to understand the latest production rollout.
3. Inspect the scripts you plan to run or modify inside the same snapshot (`scripts/` folder).
4. Use `BACKUP_MANIFEST.md` whenever you need historical checkpoints or restoration instructions.

## Adding or Promoting New Work

- Place new docs/code inside the newest snapshot directory under `Projects\backups\`.
- Update both this README and `canonical_index.json` when a newer snapshot becomes canonical.
- Keep secrets out of Git; `.env` and credential files should stay in your secured local stores.

## Need More Detail?

The snapshot's own `README.md` covers architecture, automation scripts, and daily operations.  
On the Windows host, manage the running stack from `C:\Users\billt\OneDrive\Projects\agent-zero\` using scripts such as `start-duoluga.ps1`, `status-duoluga.ps1`, and `diagnostics.ps1`. The same directory stores PowerShell helpers referenced by `canonical_index.json`.
