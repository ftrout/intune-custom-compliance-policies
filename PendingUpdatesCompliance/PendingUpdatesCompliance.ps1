# Create a COM object for the Windows Update Agent API
$UpdateSession = New-Object -ComObject Microsoft.Update.Session

# Create a searcher object to find the latest update
$Searcher = $UpdateSession.CreateUpdateSearcher()

# Search for the latest update
$Criteria = "IsInstalled=0 and Type='Software' and IsHidden=0"
$SearchResult = $Searcher.Search($Criteria)

# Get the latest update from the search result
$LatestUpdate = $SearchResult.Updates | Sort-Object -Property Date -Descending | Select-Object -First 1

# Display the latest Windows build information
$updateDate = [datetime]$LatestUpdate.LastDeploymentChangeTime

$hash = @{ PendingUpdateDays = $(New-TimeSpan -Start $updateDate -End (Get-Date)).Days }

return $hash | ConvertTo-Json -Compress