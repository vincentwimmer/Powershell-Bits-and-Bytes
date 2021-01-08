# Recently Windows has been switching off the Num Lock key on startup by default. This will fix that.
Set-ItemProperty -Path 'Registry::HKU\.DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "2"
