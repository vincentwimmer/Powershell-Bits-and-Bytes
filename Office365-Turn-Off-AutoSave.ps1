$path = "HKCU:\SOFTWARE\Microsoft\Office\16.0"
 
Set-ItemProperty -Path $path\Word -Name DontAutoSave -Value 1
Set-ItemProperty -Path $path\Excel -Name DontAutoSave -Value 1
Set-ItemProperty -Path $path\Powerpoint -Name DontAutoSave -Value 1
