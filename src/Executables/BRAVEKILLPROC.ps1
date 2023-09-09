# https://github.com/Atlas-OS/Atlas/blob/f8d027480a1916639e4a4e50abe5fe376f55b1dd/src/playbook/Executables/BRAVE.ps1

do { 
    $processesFound = Get-Process | ? { "BraveSetup" -contains $_.Name } | Select-Object -ExpandProperty Name
    if ($processesFound) { 
        Write-Host "Still running: $($processesFound -join ', ')"
        Start-Sleep -Seconds 2
    } else { 
        Remove-Item "$env:TEMP\BraveSetup.exe" -ErrorAction SilentlyContinue -Force
    }
} until (!$processesFound)
