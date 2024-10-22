<#
This is meant to be a way of converting hybrid users to cloud users without the use of third-party tools.

If you need to convert users en masse or by OU -
First run: https://github.com/vincentwimmer/Powershell-Bits-and-Bytes/blob/master/ActiveDirectory-AAD-Entra/Get-OUsWithAssignedUsers-ExportCSV.ps1
This will create CSV files for each OU with a header of "UserPrincipalName" and every UserPrincipalName assigned to the OU

or

Create a CSV with the header: UserPrincipalName
Then fill that column with the UserPrincipalNames of users that need to converted. For clarity, that would be their user@domain.com

Next, remove that / those users from the AD or Entra Sync Connector either by updating the sync configuration and unchecking the OU or move that user to an unsynced OU.

Run a Delta Sync

Check deleted users in Entra ID or M365 Admin and you should see your user or users listed as deleted

Now connect a Powershell terminal to MSOline: 
Import-Module MSOnline
Connect-MSOLService

Then update the $csvPath below and run the script against your CSV. This will restore the user and clear their ImmutableID to decouple them from the on-prem AD.

Now you should be able to verify the user / users are no longer listed as deleted and are now restored as cloud users.

#> 

$csvPath = "C:\temp\OU.csv"
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    $userPrincipalName = $user.UserPrincipalName

    Write-Host "Processing user: $userPrincipalName"
    
    restore-msoluser -UserPrincipalName $userPrincipalName
    Get-MsolUser -UserPrincipalName $userPrincipalName | Set-MsolUser -ImmutableId "$null"
}

Write-Host "All users in the CSV have been processed."
