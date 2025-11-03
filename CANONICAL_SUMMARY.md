# Duoluga Project — Up-to-Date Summary & Canonical Locations (2025-11-04)

## Main Folder / Code Structure

| Environment | Path |
|-------------|------|
| Project root (Windows) | C:\Users\billt\OneDrive\Projects\duoluga |
| Project root (Linux/Docker) | /projects/duoluga |
| Canonical snapshot (Windows) | C:\Users\billt\OneDrive\Projects\backups\2025-11-04_V1.4.1_FUZZY_LUO_FIX |
| Canonical snapshot (Linux/Docker) | /mnt/AgentO/projects/backups/2025-11-04_V1.4.1_FUZZY_LUO_FIX |
| Backups root | C:\Users\billt\OneDrive\Projects\backups |
| Code & scripts | /projects/duoluga/scripts |
| Memory assets | /projects/duoluga/memory |
| Docs | /projects/duoluga/documentation |

## Canonical Documentation & Key Files

| Purpose | Path |
|---------|------|
| Project scope / README | documentation/DUOLUGA_PROJECT_SCOPE.md |
| Architecture (RAG bridge) | documentation/DUOLUGA_RAG_LOOKUP_BRIDGE.md |
| Release notes | documentation/DUOLUGA_V1_RELEASE_NOTES.md |
| Latest session log | documentation/SESSION_2025-10-19_DUOLUGA_RAG_COMPLETE.md |
| Backup manifest | documentation/BACKUP_MANIFEST.md |
| Backend API | scripts/duoluga_api.py |
| Lookup middleware | scripts/lookup_bridge.py |
| Translation memories | memory/translations_clean.jsonl, memory/duoluga_word_memory_clean.jsonl |
| n8n fallback workflow docs | infrastructure/n8n/README.md |

## Current Project Status

- **Version:** 1.4.1 "Fuzzy-Luo-Fix"
- **Status:** production-ready
- **Capabilities:** Lookup index, bridge middleware, LLM fallback, Redis/JSON caching
- **Docs & logs:** All session reports, release notes, and architecture guides live in the snapshot directories above.
- **Backups:** Latest verified backup at C:\Users\billt\OneDrive\Projects\backups\2025-10-20_RAG_V1_COMPLETE; see documentation/BACKUP_MANIFEST.md for details.
- **Next enhancements:** Semantic search, multi-language expansion, ongoing enrichment using OpenRouter within the RAG pipeline (see roadmap in the docs).

## Staying Up to Date

1. Start with DUOLUGA_PROJECT_SCOPE.md for onboarding and operational status.
2. Review the latest session log to understand the most recent changes.
3. Explore the scripts/ directory for automation and backend entry points.
4. Use BACKUP_MANIFEST.md and the dated backup directories for recovery or audits.

**Reminder:** Run scripts/sync_canonical_docs.ps1 after updating canonical_index.json so this summary and the repository README stay in sync.
