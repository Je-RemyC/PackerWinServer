NetSh Advfirewall set allprofiles state off
Enable-PSRemoting -Force
Set-Item wsman:\localhost\client\trustedhosts * -Force
winrm set winrm/config/service/Auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}'
Restart-Service WinRM



