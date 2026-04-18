# Get all local user accounts
$users = Get-LocalUser

# Show total count
Write-Host "Total local users:" $users.Count

# Show enabled accounts
Write-Host "`nEnabled accounts:"
$users | Where-Object { $_.Enabled } | Select-Object Name, Enabled

# Show disabled accounts
Write-Host "`nDisabled accounts:"
$users | Where-Object { -not $_.Enabled } | Select-Object Name, Enabled