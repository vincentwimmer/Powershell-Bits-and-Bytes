# Parameters
$DistributionGroupName = "New-DistributionGroup-Name"
$EmailAddresses = @("user1@example.com", "user2@example.com", "user3@example.com")


# Create the new Distribution Group
New-DistributionGroup -Name $DistributionGroupName -Type "Distribution"

# Add email addresses to the Distribution Group
foreach ($EmailAddress in $EmailAddresses) {
    Add-DistributionGroupMember -Identity $DistributionGroupName -Member $EmailAddress
}
