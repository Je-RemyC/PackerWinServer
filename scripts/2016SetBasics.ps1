Param (
    [Parameter(Mandatory=$True)]
    [string]$SetIPaddress,

    [Parameter(Mandatory=$True)]
    [string]$Server
    )


## Enable RDP

Function EnableRDP {
    reg add "HKEY_LOCAL_MACHINESYSTEM\CurrentControl\SetControl\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
    }
    
## Disable Browser IEES

Function DisableIEESC {
    $BaseKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey("LocalMachine",$Computer)
    $SubKey = $BaseKey.OpenSubKey($AdministratorsKey,$true)
    $SubKey.SetValue("IsInstalled",0,[Microsoft.Win32.RegistryValueKind]::DWORD)
    $SubKey = $BaseKey.OpenSubKey($UsersKey,$true)
    $SubKey.SetValue("IsInstalled",0,[Microsoft.Win32.RegistryValueKind]::DWORD)
    Write-Host "Successfully disabled IE ESC on $Computer"
    $SuccessComps += $Computer

## Disable Firewall

    function DisableFW   {

           $FWState = "off"

            netsh advfirewall set allprofiles state $FWState
             
            write-host "Disabling Firewall"
       }  

## Set Static IP

    function SetStaticIP {
       
            $wmi = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
            $wmi.EnableStatic("$SetIPaddress", "255.255.255.0")
            $wmi.SetGateways("192.168.2.100", 1)
            $wmi.SetDNSServerSearchOrder("192.168.2.10")
            
            Write-Host "Setting static IP Address"
        }

        function RenameServer {
            
            Rename-Computer -NewName $Server -Restart
            }
            
    
                 
                 
DisableIEESC

EnableRDP

DisableFW

SetStaticIP 

RenameServer







