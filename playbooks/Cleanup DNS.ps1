Get-VM | Select-Object -ExpandProperty NetworkAdapters | `
Select-Object VMName,IPAddresses

$VMtoDelete = Read-Host -Prompt 'Input server name'



$DNSRecord = Invoke-Command -ComputerName DC2 -credential Get-Credential -scriptblock {param ($VMtoDelete)
    
    Get-DnsServerResourceRecord -ZoneName dc9cloud2.co.uk | Where-Object {($_.RecordType -like "A") -and ($_.HostName -like "$VMtoDelete")}
    
        } -ArgumentList $VMtoDelete

        $DNSRecord.HostName

$DNSRecordToCleanUp

#Remove-DnsServerResourceRecord -ZoneName dc9cloud2.co.uk -Name $VMRecordToCleanUp -RRtype A -Force
        