[version]$currentVersion = $null
[version]$latestVersion = $null
[bool]$isUpdated = $true

$exePath = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" -Name "(default)" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty "(default)"

if ($exePath) {
    $currentVersion = (Get-Item -Path $exePath).VersionInfo.ProductVersion

    $response = Invoke-RestMethod -Uri 'https://versionhistory.googleapis.com/v1/chrome/platforms/win64/channels/stable/versions' -Method Get
    $versions = $response.versions.version
    $latestVersion = $versions[0]

    if ($currentVersion -lt $latestVersion) {
        $isUpdated = $false
    }
}

$hash = @{ IsUpdated = $isUpdated }

return $hash | ConvertTo-Json -Compress