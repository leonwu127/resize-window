$menuName = "Resizing StarRail"
$scriptPath = "C:\dev\scripts\Resize-Window.ps1"

$regPath = "HKCR:\Directory\Background\shell\ResizeStarRail"
$commandPath = "$regPath\command"

if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    New-ItemProperty -Path $regPath -Name "(Default)" -Value $menuName -PropertyType String -Force | Out-Null
    
    if ($iconPath -and (Test-Path $iconPath)) {
        New-ItemProperty -Path $regPath -Name "Icon" -Value $iconPath -PropertyType String -Force | Out-Null
    }
    
    New-Item -Path $commandPath -Force | Out-Null
    New-ItemProperty -Path $commandPath -Name "(Default)" -Value "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`"" -PropertyType String -Force | Out-Null
    Write-Host "✅ Right click menu added! Restart explorer to take effect."
} else {
    Write-Host "⚠️ Right click menu already exists, no need to add again."
}

$choice = Read-Host "Do you want to restart explorer immediately? (Y/N)"
if ($choice -eq 'Y') {
    Stop-Process -Name explorer -Force
    Start-Process explorer
}