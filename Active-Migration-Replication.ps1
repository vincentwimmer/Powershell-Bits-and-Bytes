# This script was created to minimalize system and client downtime and data loss while migrating or separating to a new fileshare when clients have the original fileshare physically mapped.
# The code will run as long as you need it to and will continuously find recently modified files and push them to the new fileshare as you switch clients over.

$src = 'D:\OldLocat\' # Don't forget the \ after the path!
$dest = 'Z:\NewLocat\' # Don't forget the \ after the path!
$MinutesSinceModified = 2 # Tune based on src size
$SecondsTillLoop = 30 # Tune based on update frequency

while ($true) {
	Get-ChildItem ($src + "*.*")  -rec | Foreach {
		$lastupdatetime=$_.LastWriteTime
		$nowtime = get-date
		if (($nowtime - $lastupdatetime).TotalMinutes -le $MinutesSinceModified){
			$UpdatePath = $_.FullName.replace($src,$dest)
			Copy-Item $_.FullName -Destination $UpdatePath
			Write-Host "Moved Modified File:" $UpdatePath
		}
	}
	$a = get-date
	Write-Host "Loop Completed. Starting Next Loop." $a
	Start-Sleep -Seconds $SecondsTillLoop
}
