Import-Module ActiveDirectory

$outputCsv = "C:\temp\AD_Users_Info.csv"

$users = Get-ADUser -Filter * -Property UserPrincipalName, DistinguishedName, physicalDeliveryOfficeName

$userInfoList = @()

foreach ($user in $users) {
    $userInfo = New-Object PSObject
    $userInfo | Add-Member -MemberType NoteProperty -Name "UserPrincipalName" -Value $user.UserPrincipalName
    $userInfo | Add-Member -MemberType NoteProperty -Name "OrganizationalUnit" -Value ((Get-ADOrganizationalUnit -Filter {DistinguishedName -like $user.DistinguishedName} | Select-Object Name).Name)
    $userInfo | Add-Member -MemberType NoteProperty -Name "physicalDeliveryOfficeName" -Value $user.physicalDeliveryOfficeName

    # Add the user info to the list
    $userInfoList += $userInfo
}

$userInfoList | Export-Csv -Path $outputCsv -NoTypeInformation
