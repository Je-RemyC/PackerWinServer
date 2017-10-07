Get-VM | Select-Object -ExpandProperty NetworkAdapters | `
Select-Object VMName,IPAddresses

#set-item wsman:\localhost\Client\TrustedHosts * -force

$IPAddress = '192.168.2.29'
$NewVMName = 'web2'

#Invoke-Command -ComputerName $IPAddress -credential Administrator -scriptblock {param ($NewVMName, $IPAddress)
#Rename-Computer -NewName $NewVMName -ComputerName $env:COMPUTERNAME

 #   } -ArgumentList $NewVMName,$IPAddress

 #Start-Sleep -s  5

Invoke-Command -ComputerName $IPAddress -credential Administrator -scriptblock {param ($IPAddress,$NewVMName)
 Add-Computer -ComputerName $env:COMPUTERNAME -NewName 'web3' -DomainName dc9cloud2.co.uk -Credential dc9cloud2\Administrator -Restart
} -ArgumentList $IPAddress,$NewVMName

    