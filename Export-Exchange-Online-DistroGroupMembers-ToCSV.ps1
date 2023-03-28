$Group = "GroupName"
$Members = (Get-DistributionGroupMember $Group -ResultSize Unlimited ).Identity
$Output = Foreach ($member in $members) { Get-Mailbox $Member | select DisplayName,PrimarySMTPAddress } 
$Output | Export-CSV -Path ("C:\Path\To\Location\$Group.csv") -NoTypeInformation
