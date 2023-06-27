$Path = "C:\Path\To\Search"
$OutputFile = "C:\Path\To\GetFilesModifiedSinceHours.csv"

$CutOffTime = (Get-Date).AddHours(-8)
$Files = Get-ChildItem -Path $Path -Recurse -File
$RecentFiles = $Files | Where-Object { $_.LastWriteTime -gt $CutOffTime }

$FileData = $RecentFiles | Select-Object FullName, LastWriteTime

$FileData | Export-Csv -Path $OutputFile -NoTypeInformation
