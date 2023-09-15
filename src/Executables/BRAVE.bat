@echo off

PowerShell -NoP -C "if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -Match 64) {$a = \"BraveBrowserSetup.exe\"} else {$a = \"BraveBrowserSetupArm64.exe\"}; Invoke-WebRequest ((Invoke-RestMethod -Uri 'https://api.github.com/repos/brave/brave-browser/releases/latest' -Method Get | ConvertTo-Json | ConvertFrom-Json).assets | where-object { $_.name -eq $a }).browser_download_url -OutFile \"%TEMP%\\BraveSetup.exe\""

cmd /c "%TEMP%\BraveSetup.exe /silent /install"

PowerShell -NoP -C "& .\BRAVEPROC.ps1"

cmd /c "del %TEMP%\BraveSetup.exe"

call :setAssociations

set "dir=%ProgramFiles%\BraveSoftware\Brave-Browser\Application"

copy /y "initial_preferences_brave" "%dir%\initial_preferences"

for /f "usebackq delims=" %%A in (`dir /b /a:d "%SYSTEMDRIVE%\Users" ^| findstr /v /i /x /c:"Public" /c:"Default User" /c:"All Users"`) do (
	echo 	PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%PUBLIC%\Desktop\Brave.lnk'); $S.TargetPath = '%dir%\brave.exe'; $S.WorkingDirectory = '%dir%'; $S.Save()"
	PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%PUBLIC%\Desktop\Brave.lnk'); $S.TargetPath = '%dir%\brave.exe'; $S.WorkingDirectory = '%dir%'; $S.Save()"

	copy /y "%PUBLIC%\Desktop\Brave.lnk" "%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned"
)

PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%dir%\Brave.lnk'); $S.TargetPath = '%dir%\brave.exe'; $S.WorkingDirectory = '%dir%'; $S.Save()"
PowerShell -NoP -C "$Content = (Get-Content '%~dp0\Layout.xml'); $Content = $Content -replace '%%ALLUSERSPROFILE%%\\Microsoft\\Windows\\Start Menu\\Programs\\Brave.lnk', '%dir%\Brave.lnk' | Set-Content '%~dp0\Layout.xml'"
exit /b 0

:setAssociations

for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	REM If the "Volatile Environment" key exists, that means it is a proper user. Built in accounts/SIDs don't have this key.
	reg query "HKU\%%A" | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > NUL 2>&1
		if not errorlevel 1 (
			PowerShell -NoP -ExecutionPolicy Bypass -File assoc.ps1 "Placeholder" "%%A" ".html:BraveHTML.FRFHIAC45C4JUB3WIVZBOG7E2E" ".htm:BraveHTML.FRFHIAC45C4JUB3WIVZBOG7E2E" "Proto:https:BraveHTML.FRFHIAC45C4JUB3WIVZBOG7E2E" "Proto:http:BraveHTML.FRFHIAC45C4JUB3WIVZBOG7E2E"
	)
)