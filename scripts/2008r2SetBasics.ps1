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

## Set Static IP

    function SetStaticIP {
       
            $wmi = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
            $wmi.EnableStatic("192.168.2.211", "255.255.255.0")
            $wmi.SetGateways("192.168.2.100", 1)
            $wmi.SetDNSServerSearchOrder("192.168.2.10")
            
            Write-Host "Setting static IP Address"
        }

SetStaticIP 

DisableFW

EnableRDP

DisableIEESC


