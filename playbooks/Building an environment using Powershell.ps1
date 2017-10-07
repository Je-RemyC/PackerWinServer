[CmdletBinding()]
Param (
    [Parameter(Mandatory=$True,Position=0)]
    [array]$CreateServer
    )


$VHDTemplateLocation = "E:\Packer\finishedbuild\Virtual Hard Disks\"
$VHDTemplateName = "packer-hyperv-iso.vhdx"



Function CreateFolderForVM {

    ForEach ($i in $CreateServer) {

    New-Item -ItemType Directory -Name $i -Path E:\

    }

}

CreateFolderForVM



Function CopyVMTemplateToFolder {

    ForEach ($i in $CreateServer) {

    cmd /c copy /z $VHDTemplateLocation\$VHDTemplateName E:\$i\$i.vhdx

    }

 }

CopyVMTemplateToFolder



Function CreateNewVM {

ForEach ($i in $CreateServer) {

New-VM -Name $i -MemoryStartupBytes 2GB -BootDevice VHD -VHDPath "E:\$i\$i.vhdx" -Path E:\$i -Generation 1 -Switch HV1switch

}

}

CreateNewVM



Function StartVM {

ForEach ($i in $CreateServer) {

start-vm -name $i

}

}

StartVM

##change the name
## change the ip

## disable the firewall