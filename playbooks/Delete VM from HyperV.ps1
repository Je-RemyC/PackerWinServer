Get-VM | Select-Object -ExpandProperty NetworkAdapters | `
Select-Object VMName,IPAddresses

$VMtoDelete = Read-Host -Prompt 'Enter Server Name'

Stop-vm -Name $VMtoDelete -TurnOff

Remove-vm -Name $VMtoDelete -force

