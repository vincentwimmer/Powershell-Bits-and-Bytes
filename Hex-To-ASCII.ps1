$hexString = "41 70 70 6c 65"
$result = ""

$hexString.Split(" ") | forEach {[char]([convert]::toint16($_,16))} | forEach {$result = $result + $_}

$result
pause
