Param (
[Parameter(Mandatory=$True)]
[string]$Server,

[Parameter(Mandatory=$True)]
[string]$StaticIP
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
            $wmi.EnableStatic($StaticIP, "255.255.255.0")
            $wmi.SetGateways("192.168.2.100", 1)
            $wmi.SetDNSServerSearchOrder("192.168.2.10")
            
            Write-Host "Setting static IP Address"
        }
 
 
 ## Rename VM
 
Function RenameVM {

Rename-Computer -NewName $Server -ComputerName $env:COMPUTERNAME

}
 
 ## Add Computer to Domain

function AddServerToDomain {

Add-Computer -DomainName dc9cloud2 -NewName $Server -Credential dc9cloud2\Administrator -Restart
}

    
    
      DisableFW
      
        do {sleep -s 2} while ($FWState -eq "on") 
           
          Write-Host "FW Disable Complete"
  

      
      SetStaticIP
      
      Sleep -s 2
      
            Write-Host "static IP set"

      RenameVM

      Sleep -s  2

     
     AddServerToDomain

  