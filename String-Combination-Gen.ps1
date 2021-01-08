function Get-Combos ($StringArray){
	$List = @()
	for ($i = 0; $i -lt [Math]::Pow(2,$StringArray.Length + 1); $i++)
	{ 
		[string[]]$Output = New-Object string[] $StringArray.length
		for ($j = 0; $j -lt $StringArray.Length; $j++)
		{ 
			if (($i -band (1 -shl ($StringArray.Length - $j -1))) -ne 0)
			{
				$Output[$j] = $StringArray[$j]
			}
		}
		$List += -join $Output
	}
	$List | Group-Object -Property Length | %{$_.Group | sort}
}

$First = Read-Host "Enter First String"

$Second = Read-Host "Enter Second String"

$Third = Read-Host "Enter Third String"

Get-Combos @("$First ","$Second ","$Third ","$Second ") | Get-Unique -asstring

write-host @"
--------------------------------------------
Combinations dumped!
--------------------------------------------
"@
	
pause
