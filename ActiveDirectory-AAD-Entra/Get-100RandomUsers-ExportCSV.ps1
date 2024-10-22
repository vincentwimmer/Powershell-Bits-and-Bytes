$outputCsv = "C:\temp\100Users.csv"

$users = Get-ADUser -Filter { extensionAttribute4 -like "*" } -Properties * | 
         Select-Object -Property * | 
         Get-Random -Count 100

$users | Export-Csv -Path $outputCsv -NoTypeInformation
