function Play {
    $Script:time = 0
    $Script:run = $true
    $Script:pressed = $false

    echo "Press W to WIN!"
    start-sleep -s 1
    echo "Ready"
    start-sleep -s 2
    echo "Set"
    start-sleep -s 2
    echo "GO!"


    while (($Script:time -lt 50) -and ($Script:run)) {
        
        if ([console]::KeyAvailable) {
            $Script:x = [System.Console]::ReadKey() 

            switch ( $x.key) {
                W { 
                    $Script:run = $false
                    $Script:pressed = $true
                }
            }
        }
        else {
            $Script:time++
            echo "!"
            start-sleep -milliseconds 10
        }
    }
    write-host ""
    if ($Script:pressed) {
        write-host "You did it in" (($Script:time * 2) / 100) "seconds!"
    }
    else {
        write-host "YOU DIDN'T EVEN TRY!"
    }
}

Play

while($true){
    $UserInput= Read-Host -Prompt 'Play again? (y)'
    
    if ($UserInput.ToLower() -eq "") {
    Clear-Host
     Play
    } else {
        break
    }
}
