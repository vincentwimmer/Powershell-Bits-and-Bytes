# Handy-Powershell-One-Liners


* ### Get CName from IPv4 Address:
```
[System.Net.Dns]::GetHostByAddress('ip.add.re.ss').HostName
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
