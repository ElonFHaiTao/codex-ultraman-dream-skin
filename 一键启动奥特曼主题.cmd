@echo off
setlocal
set "SKIN_ROOT=%~dp0"
start "Codex Ultra Light Skin" /min powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%SKIN_ROOT%windows\scripts\one-click-ultra-light.ps1"
endlocal
exit /b 0
