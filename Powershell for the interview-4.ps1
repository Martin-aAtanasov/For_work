<#
Basic script for chasing for missing C:\inetpub\wwwroot directory folder

If folder exist - continue with IIS creation
IF Folder doesn't exist - re-create folder and then continue with IIS creation

#>

# adding variable for PATH of important IIS directory and index.htm file 
$Test_IIS_DIR = Get-ChildItem -PATH C:\inetpub\wwwroot - ErrorAction SilentlyContinue 

if ($Test_IIS_DIR -ne $null){
Write-Host "The server's index file and folder is in place. No further creation is needed"

} else {
Write-Host "Server's index file and folder doesn't exist. We are getting the file from C:\DIR_IIS"
Copy-Item 'C:\inetpub\wwwroot' -Destination "C:\inetpub\" -Recurse -Force
}

# Creating IIS Server from Path C:\inetpub\wwwroot with HTTP biding towards port 80
Import-module webadministation
New-Website -Name "Marto_Test" -Port 80 -IPAddress "*" -HostHeader "" -PhysicalPath "C:\inetpub\wwwroot" -Force

# Adding additional HTTP biding on port 8080
New-WebBiding -Name "Marto_Test" -IPAddress "*" -Port 8080 -HostHeader "" -Force


# For the powershell script to work you need to create a folder in C: with name DIR_IIS.