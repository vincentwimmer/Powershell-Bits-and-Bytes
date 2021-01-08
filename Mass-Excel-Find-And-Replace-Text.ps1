<#
Use this script to find and replace text in all Excel documents 
on every worksheet in every folder starting from the Root folder.

Options:

Text Replace Style - Line 28:
(Default = 1)
	There are 2 ways to replace text.
	-Style 1 - Replaces entire cell where text is found.
	-Style 2 - Replaces exact search string text, leaves rest of cell.

Headless Mode - Line 29:
(Default = $true)
Choose to run in background ($true) or make speadsheets visible ($false) while executing.

#>

# Enter root folder of spreadsheet files.
$Path = "c:\test\"

# Modify, if needed, for other spreadsheet file types.
$files = Get-ChildItem $Path "*.xlsx" -rec

$SearchString = "STRING TO FIND"
$ReplaceText = "REPLACEMENT STRING"

$Style = 1
$Headless = $true

ForEach ($item in $files) { 
	Write-Host "$item"
	$Excel = New-Object -ComObject Excel.Application
	if ($Headless -eq $true) {
		$Excel.visible = $false
	}
	else {
		$Excel.visible = $true
	}

	$Workbook = $Excel.workbooks.open($item.Fullname)

	

	for ($i = 1; $i -lt $($Workbook.Sheets.Count() + 1); $i++) {
		$Range = $Workbook.Sheets.Item($i).Range("A1:EZ800")

		Write-Host "Page $i"
		$Search = $Range.find($SearchString)

		if ($search -ne $null) {
			$FirstAddress = $search.Address
			do {
				if ($Style -eq 1) {
				# Replace whole cell.
				$Search.value() = $ReplaceText
				} 
				else {
				# Replace quoted text.
				$Search.value() = $Search.value().Replace($SearchString, $ReplaceText)
				}
				#---------------------------------------------------------------
				$search = $Range.FindNext($search)
				Write-Host "Line Changed!"
			} while ( $search -ne $null -and $search.Address -ne $FirstAddress)
		}

	}

	$WorkBook.Save()
	$WorkBook.Close()
	[void]$excel.quit()
}
