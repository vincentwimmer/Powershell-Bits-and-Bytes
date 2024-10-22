Get-ADUser -Filter * -Property DisplayName, physicalDeliveryOfficeName | 
Select-Object DisplayName, physicalDeliveryOfficeName |
Export-Csv -Path "C:\temp\UsersOfficeNames.csv" -NoTypeInformation -Encoding UTF8
