$session = New-Object -ComObject "Microsoft.Update.Session"
$searcher = $Session.CreateUpdateSearcher()
$result = $searcher.Search("IsInstalled=0")
$vulnsCritical = ($result.Updates | Where-Object { $_.MsrcSeverity -eq "Critical" }).Count

$hash = @{ CriticalVulnCount = $vulnsCritical }
return $hash | ConvertTo-Json -Compress