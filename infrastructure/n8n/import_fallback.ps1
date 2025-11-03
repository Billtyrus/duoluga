<#!
.SYNOPSIS
    Imports or verifies the n8n fallback workflow automatically.
.DESCRIPTION
    Reads credentials either from environment variables or from the Agent Zero
    secret vault, uploads the YAML workflow via n8n's REST API, verifies
    successful import, and logs the result.
#>

param(
    [string]$YamlPath = "C:\Users\billt\OneDrive\Projects\duoluga\infrastructure\n8n\n8n_fallback_workflow.yaml",
    [string]$LogPath  = "C:\Users\billt\OneDrive\Projects\duoluga\logs\n8n_import.log"
)

if (-not (Test-Path $YamlPath)) {
    Write-Error "Workflow file not found at $YamlPath"
    exit 1
}

if (-not (Test-Path (Split-Path $LogPath -Parent))) {
    New-Item -ItemType Directory -Path (Split-Path $LogPath -Parent) | Out-Null
}

$N8N_URL = $env:N8N_URL
if (-not $N8N_URL) {
    $N8N_URL = "http://localhost:5678"
}

try {
    $N8N_USER = (agent0 secrets get N8N_USER -q)
    $N8N_PASS = (agent0 secrets get N8N_PASS -q)
    if (-not $N8N_USER -or -not $N8N_PASS) {
        throw "Empty values from Agent Zero secrets"
    }
} catch {
    Write-Host "Agent Zero secrets unavailable; falling back to environment variables."
    $N8N_USER = $env:N8N_USER
    $N8N_PASS = $env:N8N_PASS
}

if (-not $N8N_USER -or -not $N8N_PASS) {
    Write-Error "Missing credentials. Set N8N_USER/N8N_PASS or store them in Agent Zero secrets."
    exit 1
}

$encoded = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$N8N_USER`:$N8N_PASS"))
$headers = @{ Authorization = "Basic $encoded" }

Write-Host "Importing fallback workflow from $YamlPath"

try {
    $resp = Invoke-RestMethod -Uri "$N8N_URL/rest/workflows" -Method Post `
        -Headers $headers -ContentType "multipart/form-data" -InFile $YamlPath -ErrorAction Stop
    "[$(Get-Date -Format u)] SUCCESS workflow imported: $($resp.name)" | Out-File -Append $LogPath
} catch {
    "[$(Get-Date -Format u)] ERROR import failed: $($_.Exception.Message)" | Out-File -Append $LogPath
    exit 1
}

try {
    $list = Invoke-RestMethod -Uri "$N8N_URL/rest/workflows" -Headers $headers -ErrorAction Stop
    if ($list.name -contains "n8n_fallback_workflow") {
        "[$(Get-Date -Format u)] INFO workflow present" | Out-File -Append $LogPath
        Write-Host "Verified workflow present in n8n."
    } else {
        "[$(Get-Date -Format u)] WARN workflow not found after import check" | Out-File -Append $LogPath
        Write-Host "Warning: workflow not found after import check."
    }
} catch {
    "[$(Get-Date -Format u)] WARN verification failed: $($_.Exception.Message)" | Out-File -Append $LogPath
    Write-Host "Warning: verification request failed."
}
