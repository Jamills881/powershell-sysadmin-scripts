$outputFile = "C:\Users\Jarrod\Desktop\Service-Report-$(Get-Date -Format 'yyyy-MM-dd').txt"
# Service Health Report
$reportDate = Get-Date -Format "yyyy-MM-dd HH:mm"
$computerName = $env:COMPUTERNAME
$outputFile = "C:\Users\Jarrod\Desktop\Service-Report-$(Get-Date -Format 'yyyy-MM-dd').txt"

$report = @()
$report += "================================"
$report += "Service Health Report"
$report += "Computer: $computerName"
$report += "Date: $reportDate"
$report += "================================"
$report += ""
$report += "Critical Service Status:"
$report += "------------------------"

$criticalServices = @("Spooler", "WinDefend", "wuauserv", "LanmanServer")

foreach ($serviceName in $criticalServices) {
    $service = Get-Service -Name $serviceName
    $report += "$serviceName : $($service.Status)"
}

$report += ""
$report += "================================"
$report += "Report Complete"
$report += "================================"

# Display on screen
$report

# Save to file
$report | Out-File -FilePath $outputFile
Write-Host "`nReport saved to: $outputFile" -ForegroundColor Cyan