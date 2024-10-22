<#
Script will output all users that are not part of any group that contains "EXCLUGROUP" (or whatever you set it to)

Operation:
- Find Groups by DisplayName
- Build list of Users in each group
- Create list of unique Object IDs for each user
- Get all users
- Create a new list of users from all users that do not contain the unique Object IDs compiled from groups.
- Export to CSV

#>

$EXCLUGROUPGroups = Get-AzureADGroup -All $true | Where-Object {$_.DisplayName -like "*EXCLUGROUP*"}

$EXCLUGROUPGroupMembers = @()
foreach ($group in $EXCLUGROUPGroups) {
    $EXCLUGROUPGroupMembers += Get-AzureADGroupMember -ObjectId $group.ObjectId | Where-Object {$_.ObjectType -eq "User"}
}

$UniqueEXCLUGROUPMembers = $EXCLUGROUPGroupMembers | Select-Object ObjectId -Unique

$AllUsers = Get-AzureADUser -All $true

$UsersNotInEXCLUGROUPGroups = $AllUsers | Where-Object {$_.ObjectId -notin $UniqueEXCLUGROUPMembers.ObjectId}

$UsersNotInEXCLUGROUPGroups  | Export-CSV "C:\temp\EXCLUGROUPUsers.csv"
