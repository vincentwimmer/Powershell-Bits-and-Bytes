# Import the ActiveDirectory module if it's not already loaded
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Specify the distribution group name
$groupName = 'AllUserEmailDistro'

# Check if the distribution group exists
$group = Get-DistributionGroup -Identity $groupName -ErrorAction SilentlyContinue

if ($group -ne $null) {
    # Get all AD users with an email address
    $adUsers = Get-ADUser -Filter 'EmailAddress -like "*"' -Properties EmailAddress

    # Add all AD users' email addresses to the distribution group
    foreach ($user in $adUsers) {
        try {
            Add-DistributionGroupMember -Identity $groupName -Member $user.EmailAddress
            Write-Host "Successfully added $($user.EmailAddress) to $groupName" -ForegroundColor Green
        } catch {
            Write-Host "Failed to add $($user.EmailAddress) to ${groupName}: $_" -ForegroundColor Red
        }
    }
} else {
    Write-Host "The distribution group $groupName does not exist" -ForegroundColor Red
}
