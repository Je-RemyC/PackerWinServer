Get-VM | Select-Object -ExpandProperty NetworkAdapters | `
Select-Object VMName,IPAddresses

$VMtoDelete = 'web1'

Stop-vm -Name $VMtoDelete -TurnOff

Remove-vm -Name $VMtoDelete -force

New-Pssession -ComputerName DC2 -Credential dc9cloud2\Administrator

Get-PSSession

$PSsessionID = ''

Enter-Pssession -Id $PSsessionID

Get-DnsServerResourceRecord -ZoneName dc9cloud2.co.uk | Where-Object {($_.RecordType -like "A") -and ($_.HostName -like "$VMtoDelete")}

Remove-DnsServerResourceRecord -ZoneName dc9cloud2.co.uk -Name $VMtoDelete -RRtype A -Force

Exit-PSSession

Enter-Pssession -Id $PSsessionID