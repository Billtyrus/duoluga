#Requires -Version 7.0
param(
    [string]$IndexPath = "canonical_index.json",
    [string]$ReadmePath = "README.md",
    [string]$SummaryPath = "CANONICAL_SUMMARY.md"
)

function Format-InlineCode {
    param([string]$Value)
    return "$([char]96)$Value$([char]96)"
}

function New-ReadmeContent {
    param(
        [pscustomobject]$Index
    )

    $projectRootWindows = $Index.project_root.windows
    $projectRootLinux = $Index.project_root.linux
    $snapshot = $Index.canonical_snapshot
    $windowsSnapshot = $snapshot.windows_path
    $linuxSnapshot = $snapshot.linux_path
    $version = $snapshot.version
    $codename = $snapshot.codename
    $asOf = $snapshot.as_of

    $docs = $Index.canonical_docs
    $code = $Index.code_roots
    $memory = $Index.memory_assets
    $backup = $Index.backup_reference

    $readme = @"
# Duoluga Project – Canonical Entry Point

This repository is the **directory of record** for the Duoluga translation platform.  
Source code, documentation, and backups live in dated snapshots outside the repo; use this guide to land on the right version.

## Current Canonical Snapshot ($asOf)

- **Version:** $version "$codename"
- **Project root (Windows):** $(Format-InlineCode $projectRootWindows)
- **Project root (Linux/Docker):** $(Format-InlineCode $projectRootLinux)
- **Snapshot root (Windows):** $(Format-InlineCode $windowsSnapshot)
- **Snapshot root (Linux/Docker):** $(Format-InlineCode $linuxSnapshot)
- **Key docs** (paths relative to the snapshot root; swap the prefix for container paths when inside Docker):
  - Project scope & onboarding: $(Format-InlineCode $docs.project_scope)
  - Architecture (RAG bridge): $(Format-InlineCode $docs.architecture)
  - Release notes: $(Format-InlineCode $docs.release_notes)
  - Latest session log: $(Format-InlineCode $docs.session_log)
  - Backup manifest: $(Format-InlineCode $docs.backup_manifest)
  - API entry point: $(Format-InlineCode $code.backend_entrypoint)
  - Lookup middleware: $(Format-InlineCode $code.lookup_middleware)
  - Translation memories: $(Format-InlineCode $memory.sentence_memory), $(Format-InlineCode $memory.word_memory)
- **Support tooling**:
  - n8n fallback workflow and import helper: see $(Format-InlineCode $code.infrastructure_docs) in this repository (covers credentials, import script, and logging paths)

For machine-readable pointers, check [`canonical_index.json`](canonical_index.json).  
For a human-readable overview, see [`CANONICAL_SUMMARY.md`](CANONICAL_SUMMARY.md).

## How to Get Up to Date Quickly

1. Read `DUOLUGA_PROJECT_SCOPE.md` for status, recovery procedures, and roadmap.
2. Review the latest session log to understand recent production changes.
3. Inspect the scripts you plan to run or modify inside the same snapshot (`scripts/` folder).
4. Use `BACKUP_MANIFEST.md` whenever you need historical checkpoints or restoration instructions.

## Adding or Promoting New Work

- Place new docs/code inside the newest snapshot directory under `Projects\backups\`.
- Update `canonical_index.json`, then run `scripts/sync_canonical_docs.ps1` to regenerate this README and the canonical summary.
- Do not commit production credentials; `.env` files and secrets stay outside Git as already practiced.

## Need More Detail?

The snapshot's own `README.md` covers architecture, automation scripts, and daily operations.  
On the Windows host, manage the running stack from `C:\Users\billt\OneDrive\Projects\agent-zero\` using scripts such as `start-duoluga.ps1`, `status-duoluga.ps1`, and `diagnostics.ps1`. The same directory stores PowerShell helpers referenced by `canonical_index.json`.

Update these files whenever a newer snapshot becomes the canonical state to keep onboarding seamless for future teammates and LLMs.
"@

    return $readme
}

function New-SummaryContent {
    param(
        [pscustomobject]$Index
    )

    $snapshot = $Index.canonical_snapshot
    $windowsSnapshot = $snapshot.windows_path
    $linuxSnapshot = $snapshot.linux_path
    $version = $snapshot.version
    $codename = $snapshot.codename
    $asOf = $snapshot.as_of

    $projectRootWindows = $Index.project_root.windows
    $projectRootLinux = $Index.project_root.linux
    $backupsRootWindows = Split-Path -Parent $windowsSnapshot

    $docs = $Index.canonical_docs
    $code = $Index.code_roots
    $memory = $Index.memory_assets
    $backup = $Index.backup_reference
    $dockerPaths = $Index.docker_paths

    $summary = @"
# Duoluga Project — Up-to-Date Summary & Canonical Locations ($asOf)

## Main Folder / Code Structure

| Environment | Path |
|-------------|------|
| Project root (Windows) | $projectRootWindows |
| Project root (Linux/Docker) | $projectRootLinux |
| Canonical snapshot (Windows) | $windowsSnapshot |
| Canonical snapshot (Linux/Docker) | $linuxSnapshot |
| Backups root | $backupsRootWindows |
| Code & scripts | $($dockerPaths.scripts) |
| Memory assets | $($dockerPaths.memory) |
| Docs | $($dockerPaths.docs) |

## Canonical Documentation & Key Files

| Purpose | Path |
|---------|------|
| Project scope / README | $($docs.project_scope) |
| Architecture (RAG bridge) | $($docs.architecture) |
| Release notes | $($docs.release_notes) |
| Latest session log | $($docs.session_log) |
| Backup manifest | $($docs.backup_manifest) |
| Backend API | $($code.backend_entrypoint) |
| Lookup middleware | $($code.lookup_middleware) |
| Translation memories | $($memory.sentence_memory), $($memory.word_memory) |
| n8n fallback workflow docs | $($code.infrastructure_docs) |

## Current Project Status

- **Version:** $version "$codename"
- **Status:** $($snapshot.status)
- **Capabilities:** Lookup index, bridge middleware, LLM fallback, Redis/JSON caching
- **Docs & logs:** All session reports, release notes, and architecture guides live in the snapshot directories above.
- **Backups:** Latest verified backup at $($backup.latest_verified_backup); see $($docs.backup_manifest) for details.
- **Next enhancements:** Semantic search, multi-language expansion, ongoing enrichment using OpenRouter within the RAG pipeline (see roadmap in the docs).

## Staying Up to Date

1. Start with `DUOLUGA_PROJECT_SCOPE.md` for onboarding and operational status.
2. Review the latest session log to understand the most recent changes.
3. Explore the `scripts/` directory for automation and backend entry points.
4. Use `BACKUP_MANIFEST.md` and the dated backup directories for recovery or audits.

**Reminder:** Run `scripts/sync_canonical_docs.ps1` after updating `canonical_index.json` so this summary and the repository README stay in sync.
"@

    return $summary
}

if (-not (Test-Path $IndexPath)) {
    Write-Error "canonical index not found at $IndexPath"
    exit 1
}

$indexJson = Get-Content -Raw -Path $IndexPath | ConvertFrom-Json

$readmeContent = New-ReadmeContent -Index $indexJson
$summaryContent = New-SummaryContent -Index $indexJson

Set-Content -Path $ReadmePath -Value $readmeContent -Encoding UTF8
Set-Content -Path $SummaryPath -Value $summaryContent -Encoding UTF8
