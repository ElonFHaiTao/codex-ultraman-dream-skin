[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common-windows.ps1')
. (Join-Path $PSScriptRoot 'theme-windows.ps1')

$runtime = Get-DreamSkinNodeRuntime
$codex = Get-DreamSkinCodexInstall
$stateRoot = Join-Path $env:LOCALAPPDATA 'CodexDreamSkin'
$themePath = Join-Path $stateRoot 'active-theme\theme.json'
$theme = if (Test-Path -LiteralPath $themePath -PathType Leaf) {
  (Read-DreamSkinUtf8File -Path $themePath) | ConvertFrom-Json
} else {
  $null
}

Write-Host "Node.js: $($runtime.Version)"
Write-Host "Node path: $($runtime.Path)"
Write-Host "Codex package: $($codex.PackageFullName)"
Write-Host "Codex executable: $($codex.Executable)"
Write-Host "Theme state: $stateRoot"
if ($theme) {
  Write-Host "Active theme: $($theme.name) [$($theme.id)]"
} else {
  Write-Host 'Active theme: not installed'
}
Write-Host 'Environment check passed.' -ForegroundColor Green
