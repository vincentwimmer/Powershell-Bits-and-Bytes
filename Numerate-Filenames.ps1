$num = 0
$files = Get-ChildItem -path "C:\TestFolder" -file -Filter *.jpg;
  ForEach ($file in $files)
  {
  $n = ([string]$num).PadLeft(3,'0')
  $file | Rename-Item -NewName {$n + ".jpg"}
  $num += 1
  }
