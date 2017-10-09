## Disable Browser IEES

Function DisableIEESC {
$BaseKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey("LocalMachine",$Computer)
$SubKey = $BaseKey.OpenSubKey($AdministratorsKey,$true)
$SubKey.SetValue("IsInstalled",0,[Microsoft.Win32.RegistryValueKind]::DWORD)
$SubKey = $BaseKey.OpenSubKey($UsersKey,$true)
$SubKey.SetValue("IsInstalled",0,[Microsoft.Win32.RegistryValueKind]::DWORD)
Write-Host "Successfully disabled IE ESC on $Computer"
$SuccessComps += $Computer
}
catch {
Write-Host "Failed to disable IE ESC on $Computer"
$FailedComps += $Computer
}

## Enable RDP

Function EnableRDP {
Reg add “\\$computername\HKLM\SYSTEM\CurentControlSet\Control\Terminal Server”  /v fDenyTSConnections /t REG_DWORD /d 1 /f
}


## Disable Firewall

Function DisableFW {
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
}

DisableFW

EnableRDP

EnableRDP


