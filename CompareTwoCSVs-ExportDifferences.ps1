# Define CSV file paths
$StoredData = "StoredData.csv"
$NewData = "NewData.csv"
$outputFile = "StoredVsNewDataDifferences.csv"

$SData = Import-Csv -Path $StoredData
$NewData = Import-Csv -Path $NewData

# Properties to compare
$propertiesToCompare = @(
    'HeaderValue1', 'HeaderValue2', 'HeaderValue3', 'HeaderValue4'
)

$DataWithDifferences = @()

# Compare each line based on matching value
foreach ($SDat in $SData) {
    $NewDat = $NewData | Where-Object { 
        $_.HeaderValue1 -eq $SDat.HeaderValue1 
    }

    if ($NewDat) {
        $hasDifferences = $false
        $differences = @{}

        foreach ($prop in $propertiesToCompare) {
            $NewDataProp = $prop

            $StoredDataValue = $SDat.$prop
            $NewDataValue = $NewDat.$NewDataProp

            if ($StoredDataValue -ne $NewDataValue) {
                $hasDifferences = $true
                $differences[$prop] = @{
                    'StoredDataValue' = $StoredDataValue
                    'NewDataValue' = $NewDataValue
                }
            }
        }

        # Add Differences to Output
        if ($hasDifferences) {
            $DatWithDiffs = $SDat.PSObject.Copy()
            $DatWithDiffs | Add-Member -NotePropertyName "DifferencesFound" -NotePropertyValue ($differences | ConvertTo-Json)
            $DataWithDifferences += $DatWithDiffs
        }
    }
}

# Export Data
if ($DataWithDifferences.Count -gt 0) {
    $DataWithDifferences | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8
    Write-Host "Found $($DataWithDifferences.Count) Data with differences."
    Write-Host "Results exported to: $outputFile"
} else {
    Write-Host "No differences found between the files."
}
