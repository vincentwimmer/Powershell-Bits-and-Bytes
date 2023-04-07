# Specify the distribution group name and the new email address
$groupName = 'DistroGroup'
$newEmailAddress = 'New@Email.com'

# Change the distribution group's email address
Set-DistributionGroup -Identity $groupName -PrimarySmtpAddress $newEmailAddress

# Verify the change
$updatedGroup = Get-DistributionGroup -Identity $groupName
Write-Host "The email address for the distribution group $groupName has been updated to $($updatedGroup.PrimarySmtpAddress)" -ForegroundColor Green
