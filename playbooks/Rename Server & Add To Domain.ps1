Param (
[Parameter(Mandatory=$True)]
[string]$Server
)

 
 ## Rename VM
 
Function RenameVM {

Rename-Computer -NewName $Server -ComputerName $env:COMPUTERNAME

}
 
 ## Add Computer to Domain

function AddServerToDomain {

Add-Computer -DomainName dc9cloud2 -NewName $Server -Credential dc9cloud2\Administrator -Restart
}

 
      
     

      RenameVM


     
     AddServerToDomain

  