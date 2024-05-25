$sku = (Get-ComputerInfo).WindowsEditionId

$hash = @{ WindowsSku = $sku }

return $hash | ConvertTo-Json -Compress