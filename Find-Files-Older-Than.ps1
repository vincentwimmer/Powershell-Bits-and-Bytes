$time = (Get-Date).AddDays(-730)
$size = 1MB
$path = "C:\"
$outpath = ([Environment]::GetFolderPath("Desktop")+"\output.csv")
Get-ChildItem $path -Recurse | Where-Object {$_.LastWriteTime -lt $time -and $_.Length -gt $size} | Export-CSV $outpath
