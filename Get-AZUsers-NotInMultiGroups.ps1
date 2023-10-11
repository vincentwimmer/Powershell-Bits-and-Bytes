<#
Script will output all users that are not part of any group that contains "EXG1" or "EXG2" (or whatever you set it to)

Operation:
- Find Groups by DisplayName
- Build list of Users in each group
- Create list of unique Object IDs for each user
- Get all users
- Create a new list of users from all users that do not contain the unique Object IDs compiled from groups.
- Export to CSV

#>

$EXG1EXG2Groups = Get-AzureADGroup -All $true | Where-Object {
    $_.DisplayName -like "*EXG1*" -or $_.DisplayName -like "*EXG2*"
}

$EXG1EXG2GroupMembers = @()
foreach ($group in $EXG1EXG2Groups) {
    $EXG1EXG2GroupMembers += Get-AzureADGroupMember -ObjectId $group.ObjectId | Where-Object {$_.ObjectType -eq "User"}
}

$UniqueEXG1EXG2Members = $EXG1EXG2GroupMembers | Select-Object ObjectId -Unique

$AllUsers = Get-AzureADUser -All $true

$UsersNotInEXG1EXG2Groups = $AllUsers | Where-Object {$_.ObjectId -notin $UniqueEXG1EXG2Members.ObjectId}

$UsersNotInEXG1EXG2Groups | Export-CSV "C:\temp\NonEXG1NonEXG2Users.csv"
