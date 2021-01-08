<#
Must have Dell OpenManage installed:
https://www.dell.com/support/article/us/en/19/sln312492/support-for-dell-emc-openmanage-server-administrator-omsa?lang=en
Ever wanted to easily pull your physical drive information from Dell controllers?
Well look no farther!
Run this on your system and it will provide you with:
Disk Number
Manufacturer
Model
Serial Number
Capacity
Sector Size
Speed
Connection Type
Feel free to change the code and simply use:
omreport storage pdisk controller=0
to pull a full report of your physical drives on Controller 0.
#>

$DiskResult = @()
$Controllers = Get-WmiObject Win32_SCSIController | Select-Object DriverName
$ControllerCount = $Controllers.count
foreach ($Controller in $ControllerCount) {
    $storage = omreport storage pdisk controller=0
    foreach ($Line in $storage) {


        if (($Line) -like "ID*") {
            $DiskInfo = New-Object System.Object
            $Line = $Line.split(":")[1..3].Replace(" ", "")
            $Line = $Line[2]
            $DiskInfo | Add-Member -MemberType NoteProperty -Name ID -Value $Line
        }

        if (($Line) -like "*Protocol*") {
            $Line = $Line.Split(":")[1]
            $Line = $Line.Split(" ")[1].Replace(" ", "")
            $DiskInfo | Add-Member -MemberType NoteProperty -Name Bus -Value $Line
        }

        if (($Line) -like "Capacity*") {
            $Line = $Line.Split(":")[1]
            $Line = $Line.Split("GB")[0].Replace(" ", "")
            $DiskInfo | Add-Member -MemberType NoteProperty -Name Capacity -Value $Line
        }
  
        if (($Line) -like "Product*") {
            $Line2 = $Line.Split(":")[1]
            $Line2 = $Line2.Split(" ")[1]
            $DiskInfo | Add-Member -MemberType NoteProperty -Name Manufacturer -Value $Line2
        }

        if (($Line) -like "Product ID*") {
            $Line = $Line.Split(":")[1]
            $Line = $Line.Split(" ")[2]
            $DiskInfo | Add-Member -MemberType NoteProperty -Name Model -Value $Line
        }

        if (($Line) -like "Serial*") {
            $Line = $Line.Split(":")[1].Replace(" ", "")
            $DiskInfo | Add-Member -MemberType NoteProperty -Name Serial -Value $Line
        } 

        if (($Line) -like "Negotiated Speed*") {
            $Line = $Line.Split(":")[1].Replace(" ", "")
            $DiskInfo | Add-Member -MemberType NoteProperty -Name Speed -Value $Line
        }

        if (($Line) -like "Sector Size*") {
            $Line = $Line.Split(":")[1].Replace(" ", "")
            $DiskInfo | Add-Member -MemberType NoteProperty -Name SecSize -Value $Line
            $DiskResult += $DiskInfo
        }
    
    }
}
$DiskOutput = 
@(
    $EntryCount = 0
    foreach ($entry in $DiskResult) {
    
        [pscustomobject] [ordered] @{ # Only if on PowerShell V3
            'Disk        ' = $DiskResult.ID[$EntryCount]
            'Manufacturer' = $DiskResult.Manufacturer[$EntryCount]
            'Model       ' = $DiskResult.Model[$EntryCount]
            'Serial      ' = $DiskResult.Serial[$EntryCount]
            'Capacity    ' = $DiskResult.Capacity[$EntryCount] + 'GB'
            'Sector Size ' = $DiskResult.SecSize[$EntryCount]
            'Speed       ' = $DiskResult.Speed[$EntryCount]
            'Type        ' = $DiskResult.Bus[$EntryCount]
        }
        $EntryCount++
    }
)

$DiskOutput | ft -AutoSize
