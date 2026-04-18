# System Information Report
$computerName = $env:COMPUTERNAME
$reportDate = Get-Date -Format "yyyy-MM-dd HH:mm"

Write-Host "================================"
Write-Host "System Information Report"
Write-Host "Computer: $computerName"
Write-Host "Date: $reportDate"
Write-Host "================================"

# Get OS Information
$os = Get-CimInstance Win32_OperatingSystem
Write-Host "`nOperating System: " $os.Caption
Write-Host "Version: " $os.Version
Write-Host "Last Reboot: " $os.LastBootUpTime

# Get CPU Information
$cpu = Get-CimInstance Win32_Processor
Write-Host "`nCPU: " $cpu.Name
Write-Host "Cores: " $cpu.NumberOfCores
Write-Host "Logical Processors: " $cpu.NumberOfLogicalProcessors

# Get RAM Information
$ram = Get-CimInstance Win32_ComputerSystem
$ramGB = [math]::Round($ram.TotalPhysicalMemory / 1GB, 2)
Write-Host "`nTotal RAM: $ramGB GB"

# Get Disk Space Information
Write-Host "`nDisk Space:"
Write-Host "------------------------"
$disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

foreach ($disk in $disks) {
    $totalGB = [math]::Round($disk.Size / 1GB, 2)
    $freeGB = [math]::Round($disk.FreeSpace / 1GB, 2)
    $usedGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB, 2)
    $percentFree = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 1)
    
    Write-Host "Drive $($disk.DeviceID) - Total: $totalGB GB | Used: $usedGB GB | Free: $freeGB GB | $percentFree% free"
}

# Alert on low disk space
Write-Host "`nDisk Space Alerts:"
Write-Host "------------------------"
$threshold = 15

foreach ($disk in $disks) {
    $percentFree = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 1)
    if ($percentFree -lt $threshold) {
        Write-Host "WARNING: Drive $($disk.DeviceID) is low on space - only $percentFree% free!" -ForegroundColor Red
    } else {
        Write-Host "Drive $($disk.DeviceID) is OK - $percentFree% free" -ForegroundColor Green
    }
}

# Save report to file
$outputFile = "C:\Users\Jarrod\Desktop\PowerShell-Scripts\System-Report-$(Get-Date -Format 'yyyy-MM-dd').txt"
Write-Host "`nSaving report to file..."

# Re-run and capture to file
$reportContent = @(
    "================================"
    "System Information Report"
    "Computer: $computerName"
    "Date: $reportDate"
    "================================"
    "OS: $($os.Caption)"
    "Version: $($os.Version)"
    "Last Reboot: $($os.LastBootUpTime)"
    "CPU: $($cpu.Name)"
    "Cores: $($cpu.NumberOfCores)"
    "RAM: $ramGB GB"
)

$reportContent | Out-File -FilePath $outputFile
Write-Host "Report saved to: $outputFile" -ForegroundColor Cyan