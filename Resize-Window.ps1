Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
"@

# 配置参数
$processName = "StarRail"        # 游戏的进程名（通过任务管理器确认）
$targetWidth = 1080               # 窗口宽度（竖屏横向分辨率）
$targetHeight = 607               # 窗口高度（16:9比例计算值）
$posY = (1920 - $targetHeight)/2  # 垂直居中位置（假设竖屏高度1920）

# 查找游戏进程并调整窗口
$process = Get-Process | Where-Object { $_.ProcessName -eq $processName } | Select-Object -First 1
if ($process) {
    [Win32]::MoveWindow($process.MainWindowHandle, 0, $posY, $targetWidth, $targetHeight, $true)
    Write-Host "Windows resized to $targetWidth x $targetHeight"
} else {
    Write-Host "Game process not found!"
}