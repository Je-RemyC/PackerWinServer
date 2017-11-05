Param (
    [Parameter(Mandatory=$True)]
    [string]$SetIPaddress,

    [Parameter(Mandatory=$True)]
    [string]$Server
    )
    
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
            
    
                 
                 


DisableFW

SetStaticIP 

RenameServer







