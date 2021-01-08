#Powerball lottery number generator

#Set while flag.
$flag = 1
    
#Get a random number between 1 and 69.
function Get-Number {
    get-random @(1..69)
}

#Set the ball variables to random numbers.
function Set-Numbers {
    $script:b1 = Get-Number
    $script:b2 = Get-Number
    $script:b3 = Get-Number
    $script:b4 = Get-Number
    $script:b5 = Get-Number
}

#Check for duplicate numbers.
#Run again if there are duplicates.
#Turn off while flag if there are no duplicates.
function Check-Dupes {
    $Array = ($script:b1, $script:b2, $script:b3, $script:b4, $script:b5)
    ForEach ($Element in $Array) {
        If (($Array -match $Element).count -gt 1) {
            Set-Numbers
            $script:flag = 1
        }
        else {
            $script:flag = 0
        }
    }
}

#Loop while flag equals 1
while ($script:flag -eq 1) {
    Set-Numbers
    Check-Dupes
    #Double check to eliminate false negatives
    Check-Dupes
}

#Grab a random number between 1 and 26 (The Powerball).
$b6 = get-random @(1..26)
#Sort balls from Lowest to Highest.
$reorder = ($b1, $b2, $b3, $b4, $b5) | Sort-Object { [int]$_ }
#Echo the results.
echo "Your numbers are:"
echo "$reorder - $b6"
echo ""

#Prompt to hit Enter and close script.
pause
