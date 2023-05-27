$secureBootUefi = Confirm-SecureBootUEFI

$hash = @{ SecureBootUefi = $secureBootUefi }
return $hash | ConvertTo-Json -Compress