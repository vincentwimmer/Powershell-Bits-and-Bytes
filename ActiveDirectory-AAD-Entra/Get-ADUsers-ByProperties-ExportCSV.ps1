$DesktopPath = [Environment]::GetFolderPath("Desktop")
# Change properties as needed.
Get-ADUser -Filter * -Properties displayname, extensionattribute4, description, title, department | Select-Object displayname, extensionattribute4, description, title, department | Export-Csv -Path "$DesktopPath\all_users.csv"
