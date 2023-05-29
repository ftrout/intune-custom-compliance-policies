$tpm = Get-Tpm
[uint64]$tpmVersion = $((Get-WmiObject -Namespace "root\cimv2\security\microsofttpm" -Class Win32_Tpm).SpecVersion -split ",")[0]

$hash = @{ 
    TpmPresent     = $tpm.TpmPresent
    TpmVersion     = $tpmVersion
    TpmReady       = $tpm.TpmReady
    TpmEnabled     = $tpm.TpmEnabled
    TpmActivated   = $tpm.TpmActivated
    RestartPending = $tpm.RestartPending 
}

return $hash | ConvertTo-Json -Compress