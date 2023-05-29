$bitlockerStatus = Get-BitLockerVolume -MountPoint $env:SystemDrive

$hash = @{ 
    EncryptionMethod     = $bitlockerStatus.EncryptionMethod.ToString()
    VolumeStatus         = $bitlockerStatus.VolumeStatus.ToString()
    ProtectionStatus     = $bitlockerStatus.ProtectionStatus.ToString()
    EncryptionPercentage = $bitlockerStatus.EncryptionPercentage.ToString() 
}

return $hash | ConvertTo-Json -Compress