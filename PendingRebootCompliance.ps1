$pendingReboot = $false

$pendingRebootKeys = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootInProgress",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\PackagesPending",
    "HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts"
)

foreach ($key in $pendingRebootKeys) {
    if (Test-Path $key) {
        $pendingReboot = $true
    }
}

if ($(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Updates" -Name "UpdateExeVolatile" -ErrorAction SilentlyContinue).UpdateExeVolatile -ne 0) {
    $pendingReboot = $true
}

if ($(Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name "PendingFileRenameOperations" -ErrorAction SilentlyContinue)) {
    $pendingReboot = $true
}

if ($(Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name "PendingFileRenameOperations2" -ErrorAction SilentlyContinue)) {
    $pendingReboot = $true
}

if ($(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" -Name "DVDRebootSignal" -ErrorAction SilentlyContinue)) {
    $pendingReboot = $true
}

if ($(Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Name "JoinDomain" -ErrorAction SilentlyContinue)) {
    $pendingReboot = $true
}

if ($(Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Name "AvoidSpnSet" -ErrorAction SilentlyContinue)) {
    $pendingReboot = $true
}

if ($(Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" -Name "ComputerName" -ErrorAction SilentlyContinue).ComputerName -ne $env:COMPUTERNAME) {
    $pendingReboot = $true
}

if ($(Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\Pending" -ErrorAction SilentlyContinue)) {
    $pendingReboot = $true
}

$hash = @{ PendingReboot = $pendingReboot }
return $hash | ConvertTo-Json -Compress