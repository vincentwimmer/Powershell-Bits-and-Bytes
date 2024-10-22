# Powershell-Bits-and-Bytes

## Azure/M365 Shells:

* ### Azure Active Directory Management Shell
```
Import-Module AzureAD

Connect-AzureAD
```

* ### Exchange Online Management Shell
```
Import-Module ExchangeOnlineManagement

Connect-ExchangeOnline
```

* ### SharePoint Online Management Shell
```
Import-Module Microsoft.Online.SharePoint.PowerShell

Connect-SPOService -Url https://contoso-admin.sharepoint.com
```

* ### SharePoint Online PNP Shell
```
Import-Module PnP.PowerShell

Connect-PnPOnline -Url "https://contoso.sharepoint.com" -Interactive
```

* ### Microsoft Online Shell
```
Import-Module MSOnline

Connect-MSOLService
```

## One liners:
* ### Convert Windows Server Eval to Server Standard and activate with license
```
DISM.exe /online /Set-Edition:ServerStandard /ProductKey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX /AcceptEula
```

* ### Robocopy all folder contents to a network location and keep all ACL settings
```
robocopy "D:\" "\\HostName\Share" /E /ZB /DCOPY:T /COPYALL /R:1 /W:1 /V /TEE /LOG:Robocopy.log
```

* ### Get files modified since date
```
Get-ChildItem "D:\" -File -Recurse | Where-Object { $_.LastWriteTime -gt "01/15/2024" } | select-Object FullName, LastWriteTime
```

* ### Add AAD user to local admins
```
net localgroup administrators AzureAD\USER /add
```

* ### Get AD Users' and last password change dates:
```
Get-ADUser -filter *  -properties PwdLastSet  | sort Name | ft Name,@{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}}
```

* ### Push Azure Sync Deltas:
```
Start-ADSyncSyncCycle -PolicyType Delta
```

* ### Get all mail transactions in a date range from Exchange Shell to CSV:
```
Get-MessageTrackingLog -ResultSize Unlimited -Start "3/1/2023 8:00AM" -End "3/13/2023 5:00PM" | Export-Csv c:\temp\mail.csv
```

* ### Get CName from IPv4 Address:
```
[System.Net.Dns]::GetHostEntry('ip.add.re.ss')
```
> or
```
[System.Net.Dns]::GetHostByAddress('ip.add.re.ss').HostName
```

* ### Slowdown the output of commands:
> To use:
> - Any-Command | SlowView
```
function SlowView { process { $_; Start-Sleep -seconds 1}}
```

* ### Disconnect/Connect HyperV VM's network:
```
Disconnect-VMNetworkAdapter NameOfVM
```
```
Connect-VMNetworkAdapter -VMName NameOfVM -SwitchName VNet
```

* ### Recursively take over ownership of root and subfolders as logged in user:
```
takeown /f "c:\folder\subfolder" /r
```

* ### Recursively remove Read-Only attribute of root and subfolders/files:
```
attrib -r "c:\folder\subfolder\*.*"" /s
```

* ### Uninstall any software with "Toolbar" in the name.
```
(gwmi Win32_Product | where {$_.name -like "*toolbar*"}).uninstall()
```

* ### Skip Windows Update and Shutdown Now.
```
shutdown /s /t 0
```

* ### Find locked AD accounts and unlock them.
```
search-adaccount -lockedout | unlock-adaccount
```

* ### Gather all Windows 7 computers in Active Directory and dump to CSV.
> Great for migrating from End-of-Life!
```
Get-ADComputer -LDAPFilter '(operatingSystem=*Windows 7*)'  -Properties * | Select -Property Name,DNSHostName,operatingSystem | Export-CSV "C:\Users\%username%\Desktop\Windows7Computers.csv"
```

* ### Disable Bing Search from Start Menu.
```
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v BingSearchEnabled /t REG_DWORD /d 0 /f
```

* ### Disable Cortana Search from Start Menu.
```
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v CortanaConsent /t REG_DWORD /d 0 /f
```

* ### Move all contents of sub/folder(s) to another folder.
```
Get-ChildItem -Path "sourc" -Recurse -File | Move-Item -Destination "dest"
```

* ### Python - Update all libs.
```
pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}
```

* ### Get Weather of current IP.
```
Invoke-RestMethod https://wttr.in
```
