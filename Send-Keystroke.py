<#
In the current form:
This script will open Notepad.exe then focus on the Notepad window and start typing "wasd "

If you plan to use this in a different program:
-Change or comment "start notepad" (Ln:15)
-Change 'Notepad' in $wshell.AppActivate('Notepad') (Ln:21)
  to the name of the program you want to focus the script on. (Could be found in Task Manager)

Lastly, for special keys check out this helpful link:
https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.sendkeys?view=netframework-4.8
#>

$run = $true
echo "Sending keys. Press F12 to quit."
start notepad

$wshell = New-Object -ComObject WScript.Shell
sleep 1
echo ""
echo "Window Found: "
$wshell.AppActivate('Notepad')

while($run)
{

    if ([console]::KeyAvailable)
    {
        $x = [System.Console]::ReadKey() 

        switch ( $x.key)
        {
            F12 { $run = $false }
        }
    } 
    else
    {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('w')
        sleep 1
        $wsh.SendKeys('a')
        sleep 1
        $wsh.SendKeys('s')
        sleep 1
        $wsh.SendKeys('d')
        sleep 1
        $wsh.SendKeys(' ')
        sleep 1
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($wsh)| out-null
        Remove-Variable wsh
    }    
}
