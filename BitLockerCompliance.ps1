$bitlockerStatus = Get-BitLockerVolume -MountPoint $env:SystemDrive

$hash = @{ EncryptionMethod = $bitlockerStatus.EncryptionMethod; VolumeStatus = $bitlockerStatus.VolumeStatus; ProtectionStatus = $bitlockerStatus.ProtectionStatus; EncryptionPercentage = $bitlockerStatus.EncryptionPercentage.ToString() }
return $hash | ConvertTo-Json -Compress