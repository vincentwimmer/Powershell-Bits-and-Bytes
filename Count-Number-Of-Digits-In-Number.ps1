function Count-Digits {
    param (
        [Parameter(Mandatory=$true)]
        [long]$Number
    )

    if ($Number -eq 0) {
        return 1
    }
    
    return [math]::Floor([math]::Log10([math]::Abs($Number))) + 1
}

# Example usage
$number = 42465455
$digitCount = Count-Digits -Number $number
Write-Host "The number $number has $digitCount digits."
