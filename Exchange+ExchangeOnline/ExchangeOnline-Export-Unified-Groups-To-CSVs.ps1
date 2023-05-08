# Retrieve all Microsoft 365 Groups
$groups = Get-UnifiedGroup -ResultSize Unlimited

# Export each group's members to a CSV file named after the group
foreach ($group in $groups) {
    $groupName = $group.DisplayName
    $csvFileName = "C:\temp\$groupName.csv"
    Get-UnifiedGroupLinks -Identity $group.ExternalDirectoryObjectId -LinkType Members | 
        Select-Object DisplayName,PrimarySmtpAddress | 
        Export-Csv -Path $csvFileName -NoTypeInformation
}
