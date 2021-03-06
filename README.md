# Packer templates for creating Windows Server 2012r2 and 2016 

Note: The provided 2008r2 template does not work with Hyper-V. For some reason the WinRM.ps1 script provided in the Scripts folder doesn't enable WinRM but does for Server 2012r2 and 2016. Given the age of 2008r2, and as the template and overall process does work if you use VirtualBox instead of Hyper-V, this is an issue I can live with. 

You need the following to run the template: 

- Packer installed with a minimum version of 1.1.0 

- Hyper-V - Tested with Server 2012r2 (or VirtualBox if you want the 2008r2 builds to work) 

- Chocolatey – This is not a prerequisite but makes post installing software much easier 

 

Invoking the template 

Invoke Packer to run a template using Powershell, by navigating to one of the template folders such as E:\Packer\packerbuilders\Hyperv\2012 r2 and issuing the following command: 
```
packer build 2012_r2_HV1.json
```

 

# Scripts and Configuration files used in the build 

The Packer JSON files 

A full list of configuration options can be found here: https://www.packer.io/docs/templates/index.html 

- AutoUnattend.xml files 

Here you can specify Language options, serial numbers etc for complete handsfree installation  

- Winrm.ps1 

Configures the VM being built to accept WinRM connections from Packer, without which the build will fail 

- Install-chocolatey.ps1 

Bakes Chocolatey, the powerful Windows Package Manager into the build 

- 2016SetServerBasics.ps1 

Uploads a Powershell script to the root of C: that post build, enables setting basic server configurations 

 

# After Packer completes a build 

In the Playbooks folder, you can see a script called  'Create HyperV VM from Packer template.ps1'. This is a very basic, post image build/orchestration tool. In the Hashicorp ecosystem of products, Packer would be the component making the golden images, and Vagrant would then take over to generate multiple VM's from those builds. I prefer to use Hyper-V, therefore Powershell is the logical choice for making multiple VM's from the base image 

The script copies the image created during the Packer build and spins up a vm in Hyper-V. The script prompts for a name to use on start, accepting an array of names so more than one VM can be created per run 

The limitation of this method is I've not currently found a way of specifying OS level variables such as setting a static IP, changing the computer name, joining to a domain etc, during this phase.

To mitigate this, the Packer build uploads one of two 'Set Basics' scripts, depending on the OS Version being built

By connecting to the newly created VM console and running this script, those basic settings can be specified

NOTE: I recognise this is not a scaleable solution and will revise this in future versions of the method 
