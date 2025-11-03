# Duoluga Project — Up-to-Date Summary & Canonical Locations (2025-11-04)

## Main Folder / Code Structure

| Environment | Path |
|-------------|------|
| Windows host | `C:\Users\billt\OneDrive\Projects\duoluga\` |
| Backups | `C:\Users\billt\OneDrive\Projects\backups\2025-10-23_V1.4.0_HYBRID_ROUTING_A\` |
| Linux / Docker | `/projects/duoluga/` (mounted as `/mnt/AgentO/projects/duoluga/`) |
| Code & scripts | `/projects/duoluga/scripts/` |
| Memory assets | `/projects/duoluga/memory/` |
| Docs | `/projects/duoluga/documentation/` |

> When inside containers, replace the Windows prefix with `/projects/duoluga/`.

## Canonical Documentation & Key Files

| Purpose | Path (relative to snapshot root) |
|---------|----------------------------------|
| Project scope / README | `documentation/DUOLUGA_PROJECT_SCOPE.md` |
| Architecture (RAG bridge) | `documentation/DUOLUGA_RAG_LOOKUP_BRIDGE.md` |
| Release notes | `documentation/DUOLUGA_V1_RELEASE_NOTES.md` |
| Latest session log | `documentation/SESSION_2025-10-19_DUOLUGA_RAG_COMPLETE.md` |
| Backup manifest | `documentation/BACKUP_MANIFEST.md` |
| Backend API | `scripts/duoluga_api.py` |
| Lookup middleware | `scripts/lookup_bridge.py` |
| Translation memories | `memory/translations_clean.jsonl`, `memory/duoluga_word_memory_clean.jsonl` |

## Current Project Status

- **Version:** Duoluga RAG v1.0 (production ready as of Oct 19–20, 2025)
- **Stack:** Lookup index + bridge middleware + LLM fallback + Redis/JSON caching
- **Documentation:** All changes, session logs, and guides stored in the snapshot directories above
- **Backups:** `C:\Users\billt\OneDrive\Projects\backups\2025-10-23_V1.4.0_HYBRID_ROUTING_A\` (latest) and `…\2025-10-20_RAG_V1_COMPLETE\` (validated)
- **Next enhancements:** semantic search, multi-language expansion, continued enrichment using OpenRouter within the RAG pipeline (see roadmap in docs)

## Staying Up to Date

1. Start with `DUOLUGA_PROJECT_SCOPE.md` for onboarding and operational status.
2. Review the latest session log to understand the most recent changes.
3. Explore the `scripts/` directory for automation and backend entry points.
4. Use `BACKUP_MANIFEST.md` and the dated backup directories for recovery or audits.

**Reminder:** Keep this summary aligned with the current canonical snapshot whenever new releases go live.

