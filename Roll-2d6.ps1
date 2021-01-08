function Roll {
	$Script:d1 = get-random @(1..6)
	$Script:d2 = get-random @(1..6)
}

while($true){
  Write-Host "Press Ctrl+C to exit."
	pause

	if ($UserInput.ToLower() -eq "y") {
		Clear-Host
		Roll
		Write-Host $d1
		Write-Host $d2
	}
}
