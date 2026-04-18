# PowerShell Sysadmin Scripts

A collection of practical PowerShell scripts for Windows system administration tasks including service monitoring, system diagnostics, and disk space alerting.

## Scripts

### Check-Services.ps1
Checks the status of critical Windows services and color codes the output — green for running, red for stopped.

**Services monitored:**
- Spooler (Print Spooler)
- WinDefend (Windows Defender)
- wuauserv (Windows Update)
- LanmanServer (File Sharing)

**Usage:**
```powershell
.\Check-Services.ps1
```

---

### Service-Report.ps1
Generates a formatted service health report and saves it to a dated text file automatically.

**Output includes:**
- Computer name and timestamp
- Status of all critical services
- Report saved to desktop as Service-Report-YYYY-MM-DD.txt

**Usage:**
```powershell
.\Service-Report.ps1
```

---

### System-Info.ps1
Pulls comprehensive system information and alerts on low disk space. Saves output to a dated report file.

**Output includes:**
- Operating system version and last reboot time
- CPU model, cores, and logical processors
- Total RAM
- All drive space with used/free breakdown
- Disk space alerts for drives below 15% free

**Usage:**
```powershell
.\System-Info.ps1
```

## What I Learned
- PowerShell verb-noun command pattern
- Piping and filtering with Where-Object
- Variables, arrays, foreach loops, and if/else logic
- Get-CimInstance for querying Windows system information
- Generating formatted reports and saving output to files
- Color coded console output for quick visual status checks

## Tools Used
- Windows PowerShell
- Visual Studio Code with PowerShell extension
