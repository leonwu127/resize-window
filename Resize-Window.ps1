Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
"@

$processName = "StarRail" 
$targetWidth = 1080
$targetHeight = 607
$posY = (1920 - $targetHeight)/2

$process = Get-Process | Where-Object { $_.ProcessName -eq $processName } | Select-Object -First 1
if ($process) {
    [Win32]::MoveWindow($process.MainWindowHandle, 0, $posY, $targetWidth, $targetHeight, $true)
    Write-Host "Windows resized to $targetWidth x $targetHeight"
} else {
    Write-Host "Game process not found!"
}