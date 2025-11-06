# Powershell for Windows Updates

* ### Get last 10 installed Windows updates:
```
$Searcher.QueryHistory(0, $HistoryCount) | Sort-Object Date -Descending | Select-Object -First 10 Title, Date | ft
```

---

* ### Get most recent Windows Update statuses

```
Get-WinEvent -ProviderName Microsoft-Windows-WindowsUpdateClient -MaxEvents 20 | Where-Object { $_.Id -in 19,25,31 } | Select-Object TimeCreated, Id, Message | ft
```
  
| Value   | Meaning               |
| ------- | --------------------- |
| `19`    | Updates Installed     |
| `25`    | Checked for Updates   |
| `31`    | Updates Started       |

---

Get recent Windows Hot-Fix installs:
Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 10 | ft


Get registry settings
| Value          | Key Name       | Meaning                                 |
| -------------- | -------------- | --------------------------------------- |
| `NoAutoUpdate` | 1              | **Disables automatic updates entirely** |
| `NoAutoUpdate` | 0 (or missing) | Automatic updates are allowed           |
| `AUOptions`    | 1              | Never check (disabled)                  |
| `AUOptions`    | 2              | Notify before download/install          |
| `AUOptions`    | 3              | Auto download, notify before install    |
| `AUOptions`    | 4              | Auto download & schedule install        |
| `AUOptions`    | 5              | Allow local admin to choose             |

Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ErrorAction SilentlyContinue | Select-Object NoAutoUpdate, AUOptions, ScheduledInstallDay, ScheduledInstallTime | ft
