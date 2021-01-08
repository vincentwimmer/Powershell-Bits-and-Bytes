<#
Enter two words and join them letter by letter.
Example:
Word 1 = Dog
Word 2 = Food
Result = DFoogod
#>

$Result = ""

$Word1 = Read-Host -Prompt "Enter First Word"
$Word2 = Read-Host -Prompt "Enter Second Word"

$WordArray1 = $Word1.ToCharArray()
$WordArray2 = $Word2.ToCharArray()

$TotalLength = $WordArray1.Length + $WordArray2.Length

for ($i = 0; $i -lt $TotalLength; $i++) {
    $Result += $WordArray1[$i] + $WordArray2[$i]
}

Write-Host $Result
