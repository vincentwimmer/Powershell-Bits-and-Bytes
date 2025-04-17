# Find-SimilarOU.ps1
# Script to find the closest matching OU in Active Directory
# Takes an OU name as input and returns the path of the closest match (70% similarity or higher)

param(
    [Parameter(Mandatory=$true)]
    [string]$SearchOUName
)

Import-Module ActiveDirectory

function Get-StringSimilarity {
    param(
        [string]$String1,
        [string]$String2
    )
    
    $s1 = $String1.ToLower()
    $s2 = $String2.ToLower()
    
    $len1 = $s1.Length
    $len2 = $s2.Length
    
    if ($len1 -eq 0 -or $len2 -eq 0) { return 0 }
    
    $dist = New-Object 'int[,]' ($len1 + 1), ($len2 + 1)
    
    for ($i = 0; $i -le $len1; $i++) {
        $dist[$i, 0] = $i
    }
    
    for ($j = 0; $j -le $len2; $j++) {
        $dist[0, $j] = $j
    }
    
    # Calculate the distance
    for ($i = 1; $i -le $len1; $i++) {
        for ($j = 1; $j -le $len2; $j++) {
            $cost = if ($s2[$j - 1] -eq $s1[$i - 1]) { 0 } else { 1 }
            
            $dist[$i, $j] = [Math]::Min(
                [Math]::Min(
                    $dist[$i - 1, $j] + 1,      # Deletion
                    $dist[$i, $j - 1] + 1       # Insertion
                ),
                $dist[$i - 1, $j - 1] + $cost    # Substitution
            )
        }
    }
    
    # Calculate similarity percentage
    $maxLen = [Math]::Max($len1, $len2)
    $similarity = 100 - ($dist[$len1, $len2] / $maxLen * 100)
    
    return $similarity
}

try {
    # Get all OUs from Active Directory
    Write-Host "Searching for OUs similar to: $SearchOUName" -ForegroundColor Cyan
    $allOUs = Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
    
    # If no OUs found
    if ($allOUs.Count -eq 0) {
        Write-Host "No Organizational Units found in Active Directory." -ForegroundColor Yellow
        return
    }
    
    Write-Host "Found $($allOUs.Count) OUs in Active Directory. Calculating similarities..." -ForegroundColor Cyan
    
    # Store matches with their similarity scores
    $matches = @()
    
    # Find all potential matches
    foreach ($ou in $allOUs) {
        # Calculate similarity based on OU name
        $nameSimilarity = Get-StringSimilarity -String1 $SearchOUName -String2 $ou.Name
        
        # Also check if search term appears within OU name or vice versa
        $containsSearchTerm = $ou.Name.ToLower().Contains($SearchOUName.ToLower())
        $searchTermContainsOU = $SearchOUName.ToLower().Contains($ou.Name.ToLower())
        
        if ($containsSearchTerm -or $searchTermContainsOU) {
            $nameSimilarity = [Math]::Max($nameSimilarity, 75)
        }
        
        $matches += [PSCustomObject]@{
            Name = $ou.Name
            Path = $ou.DistinguishedName
            Similarity = $nameSimilarity
        }
    }
    
    # Sort matches
    $sortedMatches = $matches | Sort-Object -Property Similarity -Descending
    
    # Best match
    $bestMatch = $sortedMatches | Select-Object -First 1
    
    # Output
    if ($bestMatch -ne $null -and $bestMatch.Similarity -ge 70) {
        Write-Host "`nBest match found:" -ForegroundColor Green
        Write-Host "Name: $($bestMatch.Name)" -ForegroundColor Green
        Write-Host "Similarity: $($bestMatch.Similarity.ToString('0.00'))%" -ForegroundColor Green
        Write-Host "Path: $($bestMatch.Path)" -ForegroundColor Green
        
        # Return top 5
        Write-Host "`nTop matches:" -ForegroundColor Cyan
        $sortedMatches | Where-Object { $_.Similarity -ge 70 } | Select-Object -First 5 | 
            Format-Table Name, @{Name="Similarity"; Expression={$_.Similarity.ToString('0.00') + "%"}}, Path
        
        # Return the path of the best match
        return $bestMatch.Path
    }
    else {
        Write-Host "`nNo matching OU found with similarity of 70% or higher." -ForegroundColor Yellow
        
        if ($bestMatch -ne $null) {
            Write-Host "Closest match: $($bestMatch.Name) (Similarity: $($bestMatch.Similarity.ToString('0.00'))%)" -ForegroundColor Yellow
            
            # Show top 3 results anyway for reference
            Write-Host "`nTop results:" -ForegroundColor Cyan
            $sortedMatches | Select-Object -First 3 | 
                Format-Table Name, @{Name="Similarity"; Expression={$_.Similarity.ToString('0.00') + "%"}}, Path
        }
    }
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
