# n8n Fallback Workflow

- Workflow file: `n8n_fallback_workflow.yaml`
  - Import via n8n → Flows → Import to restore the Duoluga nightly recovery pipeline.
- Automation helper: `import_fallback.ps1`
  - Reads `N8N_USER`, `N8N_PASS`, and optional `N8N_URL` from Agent Zero secrets first, then environment variables.
  - Imports the workflow via the n8n REST API and writes logs to `C:\Users\billt\OneDrive\Projects\duoluga\logs\n8n_import.log`.

## Usage

```powershell
agent0 secrets set N8N_USER <username>
agent0 secrets set N8N_PASS <password>
agent0 secrets set N8N_URL http://localhost:5678

powershell -ExecutionPolicy Bypass -File .\import_fallback.ps1
```

Running the script verifies the workflow import and appends the result to the log file, making it suitable for nightly automation or rebuild hooks.
