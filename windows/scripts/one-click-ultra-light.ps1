[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$packageRoot = Split-Path -Parent $PSScriptRoot
$stateRoot = Join-Path $env:LOCALAPPDATA 'CodexDreamSkin'
$logPath = Join-Path $stateRoot 'one-click.log'

function Write-OneClickLog {
  param([Parameter(Mandatory = $true)][string]$Message)
  if (-not (Test-Path -LiteralPath $stateRoot -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $stateRoot | Out-Null
  }
  $line = '{0:yyyy-MM-dd HH:mm:ss} {1}' -f (Get-Date), $Message
  [System.IO.File]::AppendAllText(
    $logPath,
    $line + [Environment]::NewLine,
    [System.Text.UTF8Encoding]::new($true)
  )
}

function Show-OneClickError {
  param([Parameter(Mandatory = $true)][string]$Message)
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.MessageBox]::Show(
    "$Message`r`n`r`n日志：$logPath",
    '奥特曼主题启动失败',
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Error
  ) | Out-Null
}

try {
  if (Test-Path -LiteralPath $logPath -PathType Leaf) {
    Remove-Item -LiteralPath $logPath -Force
  }
  Write-OneClickLog 'Starting one-click Ultra Light Guardian workflow.'

  . (Join-Path $PSScriptRoot 'common-windows.ps1')
  . (Join-Path $PSScriptRoot 'theme-windows.ps1')

  $runtime = Get-DreamSkinNodeRuntime
  $codex = Get-DreamSkinCodexInstall
  Write-OneClickLog "Node.js $($runtime.Version): $($runtime.Path)"
  Write-OneClickLog "Codex package: $($codex.PackageFullName)"

  $activeThemePath = Join-Path $stateRoot 'active-theme\theme.json'
  $activeThemeId = $null
  if (Test-Path -LiteralPath $activeThemePath -PathType Leaf) {
    try {
      $activeTheme = (Read-DreamSkinUtf8File -Path $activeThemePath) | ConvertFrom-Json -ErrorAction Stop
      $activeThemeId = "$($activeTheme.id)"
    } catch {
      Write-OneClickLog 'Existing active theme metadata is invalid; reinstalling the bundled theme.'
    }
  }

  if ($activeThemeId -cne 'preset-ultra-light-guardian') {
    Write-OneClickLog 'Ultra Light Guardian is not active; preparing installation.'
    $runningCodex = @(Get-DreamSkinCodexProcesses -Codex $codex)
    if ($runningCodex.Count -gt 0) {
      Write-OneClickLog "Closing $($runningCodex.Count) registered Codex package process(es)."
      Stop-DreamSkinCodex -Codex $codex -AllowForce
    }

    $installScript = Join-Path $PSScriptRoot 'install-dream-skin.ps1'
    $installOutput = @(& $installScript 2>&1)
    foreach ($line in $installOutput) { Write-OneClickLog "INSTALL: $line" }
  } else {
    Write-OneClickLog 'Ultra Light Guardian is already the active theme.'
  }

  Write-OneClickLog 'Starting Codex with automatic restart consent.'
  $startScript = Join-Path $PSScriptRoot 'start-dream-skin.ps1'
  $startOutput = @(& $startScript -RestartExisting 2>&1)
  foreach ($line in $startOutput) { Write-OneClickLog "START: $line" }

  Write-OneClickLog 'SUCCESS: Codex started with Ultra Light Guardian.'
} catch {
  try { Write-OneClickLog "FAILED: $($_.Exception.Message)" } catch {}
  Show-OneClickError -Message $_.Exception.Message
  exit 1
}
