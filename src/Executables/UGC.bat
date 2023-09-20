@echo off

for /f "usebackq delims=" %%A in (`dir /b "%ProgramData%\chocolatey\lib\ungoogled-chromium\tools" /a:d ^| findstr /c:"ungoogled-chromium_"`) do set "dir=%ProgramData%\chocolatey\lib\ungoogled-chromium\tools\%%A"

if not "%dir%"=="" exit /b 0

PowerShell -NoP -C "Start-Process '%ProgramData%\chocolatey\bin\choco.exe' -ArgumentList 'install','-y','--allow-empty-checksums','ungoogled-chromium' -NoNewWindow -Wait"

if not exist "%ProgramData%\chocolatey\lib\ungoogled-chromium\tools" exit /b 0

:GenRND

setlocal EnableDelayedExpansion
set "RNDConsist=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
set /a "RND=%RANDOM% %% 36"
set "RNDStr=!RNDStr!!RNDConsist:~%RND%,1!"
if "%RNDStr:~25%"=="" (goto GenRND)
endlocal & set "RNDStr=%RNDStr%"

@echo on
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%" /ve /t REG_SZ /d "Chromium HTML Document" /f
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%" /v "AppUserModelId" /t REG_SZ /d "Chromium.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%\Application" /v "AppUserModelId" /t REG_SZ /d "Chromium.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%\Application" /v "ApplicationIcon" /t REG_SZ /d "%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico" /f
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%\Application" /v "ApplicationName" /t REG_SZ /d "Chromium" /f
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%\Application" /v "ApplicationDescription" /t REG_SZ /d "Access the Internet" /f
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%\Application" /v "ApplicationCompany" /t REG_SZ /d "The Chromium Authors" /f
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%\DefaultIcon" /ve /t REG_SZ /d "%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico" /f
reg add "HKLM\SOFTWARE\Classes\ChromiumHTM.%RNDStr%\shell\open\command" /ve /t REG_SZ /d """%ProgramData%\chocolatey\bin\chrome.exe"" --single-argument %%1" /f

reg add "HKLM\SOFTWARE\Policies\Chromium" /v "DefaultBrowserSettingEnabled" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%" /ve /t REG_SZ /d "Chromium" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities" /v "ApplicationDescription" /t REG_SZ /d "Chromium is a web browser that runs webpages and applications with lightning speed. It's fast, stable, and easy to use. Browse the web more safely with malware and phishing protection built into Chromium." /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities" /v "ApplicationIcon" /t REG_SZ /d "%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities" /v "ApplicationName" /t REG_SZ /d "Chromium" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\FileAssociations" /v ".htm" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\FileAssociations" /v ".html" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\FileAssociations" /v ".pdf" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\FileAssociations" /v ".shtml" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\FileAssociations" /v ".svg" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\FileAssociations" /v ".xht" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\FileAssociations" /v ".xhtml" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\FileAssociations" /v ".webp" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\Startmenu" /v "StartMenuInternet" /t REG_SZ /d "Chromium.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "http" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "https" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "irc" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "mailto" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "mms" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "news" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "nntp" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "sms" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "smsto" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "snews" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "tel" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "urn" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities\URLAssociations" /v "webcal" /t REG_SZ /d "ChromiumHTM.%RNDStr%" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\DefaultIcon" /ve /t REG_SZ /d "%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\InstallInfo" /v "ReinstallCommand" /t REG_SZ /d """%ProgramData%\chocolatey\bin\chrome.exe"" --make-default-browser" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\InstallInfo" /v "HideIconsCommand" /t REG_SZ /d """%ProgramData%\chocolatey\bin\chrome.exe"" --hide-icons" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\InstallInfo" /v "ShowIconsCommand" /t REG_SZ /d """%ProgramData%\chocolatey\bin\chrome.exe"" --show-icons" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\InstallInfo" /v "IconsVisible" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\shell\open\command" /ve /t REG_SZ /d """%ProgramData%\chocolatey\bin\chrome.exe"" /f

reg add "HKCR\.htm\OpenWithProgids" /v "Chromium.%RNDStr%" /f
reg add "HKCR\.html\OpenWithProgids" /v "Chromium.%RNDStr%" /f
reg add "HKCR\.pdf\OpenWithProgids" /v "Chromium.%RNDStr%" /f
reg add "HKCR\.shtml\OpenWithProgids" /v "Chromium.%RNDStr%" /f
reg add "HKCR\.svg\OpenWithProgids" /v "Chromium.%RNDStr%" /f
reg add "HKCR\.xht\OpenWithProgids" /v "Chromium.%RNDStr%" /f
reg add "HKCR\.xhtml\OpenWithProgids" /v "Chromium.%RNDStr%" /f
reg add "HKCR\.webp\OpenWithProgids" /v "Chromium.%RNDStr%" /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" /ve /t REG_SZ /d "%ProgramData%\chocolatey\bin\chrome.exe" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" /v "Path" /t REG_SZ /d "%ProgramData%\chocolatey\bin" /f

reg add "HKLM\SOFTWARE\RegisteredApplications" /v "Chromium.%RNDStr%" /d "SOFTWARE\Clients\StartMenuInternet\Chromium.%RNDStr%\Capabilities" /f

copy /y "ugc_uninstaller.exe" "%ProgramData%\chocolatey\tools"
	if %errorlevel% GTR 0 goto pastUninstall;
copy /y "ugcChocoUninstall.ps1" "%ProgramData%\chocolatey\lib\ungoogled-chromium\tools\chocolateyUninstall.ps1"
	if %errorlevel% GTR 0 goto pastUninstall;

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\UGC-%RNDStr%" /v "DisplayName" /t REG_SZ /d "Ungoogled Chromium" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\UGC-%RNDStr%" /v "DisplayIcon" /t REG_SZ /d "%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\UGC-%RNDStr%" /v "UninstallString" /t REG_SZ /d """%ProgramData%\chocolatey\tools\ugc_uninstaller.exe"" ""%RNDStr%""" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\UGC-%RNDStr%" /v "QuietUninstallString" /t REG_SZ /d """%ProgramData%\chocolatey\tools\ugc_uninstaller.exe"" ""%RNDStr%""" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\UGC-%RNDStr%" /v "NoRepair" /t REG_DWORD /d "1" /f

PowerShell -NoP -C "$Content = (Get-Content '%ProgramData%\chocolatey\lib\ungoogled-chromium\tools\chocolateyUninstall.ps1'); $Content = $Content -replace '<Command>', 'Start-Process ''%ProgramData%\chocolatey\tools\ugc_uninstaller.exe'' -Verb RunAs -ArgumentList ''%RNDStr%'',''Choco'' -Wait -ErrorAction Continue' | Set-Content '%ProgramData%\chocolatey\lib\ungoogled-chromium\tools\chocolateyUninstall.ps1'"
PowerShell -NoP -EP Unrestricted -File "UGCWIDEVINE.ps1"

@echo off

:pastUninstall

for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	REM If the "Volatile Environment" key exists, that means it is a proper user. Built in accounts/SIDs don't have this key.
	reg query "HKU\%%A" | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > NUL 2>&1
		if not errorlevel 1 (
			PowerShell -NoP -ExecutionPolicy Bypass -File assoc.ps1 "Placeholder" "%%A" ".html:ChromiumHTM.%RNDStr%" ".htm:ChromiumHTM.%RNDStr%" "Proto:https:ChromiumHTM.%RNDStr%" "Proto:http:ChromiumHTM.%RNDStr%"
	)
)

for /f "usebackq delims=" %%A in (`dir /b "%ProgramData%\chocolatey\lib\ungoogled-chromium\tools" /a:d ^| findstr /c:"ungoogled-chromium_"`) do set "dir=%ProgramData%\chocolatey\lib\ungoogled-chromium\tools\%%A"

if "%dir%"=="" exit /b 0

copy /y "Chromium.Web.Store.crx" "%ProgramData%\chocolatey\lib\ungoogled-chromium"
copy /y "uBlock.Origin.crx" "%ProgramData%\chocolatey\lib\ungoogled-chromium"
copy /y "chromium.ico" "%ProgramData%\chocolatey\lib\ungoogled-chromium"

copy /y "initial_preferences_ugc" "%dir%\initial_preferences"

reg add "HKLM\SOFTWARE\WOW6432Node\Google" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Google\Chrome" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions" /f

reg add "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\ocaahdebbfolfmndjeplogmgcagdmblk" /v "Path" /t REG_SZ /d "%ProgramData%\chocolatey\lib\ungoogled-chromium\Chromium.Web.Store.crx" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\ocaahdebbfolfmndjeplogmgcagdmblk" /v "Version" /t REG_SZ /d "1.5.3.1" /f

reg add "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\cjpalhdlnbpafiamejdnhcphjbkeiagm" /v "Path" /t REG_SZ /d "%ProgramData%\chocolatey\lib\ungoogled-chromium\uBlock.Origin.crx" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\cjpalhdlnbpafiamejdnhcphjbkeiagm" /v "Version" /t REG_SZ /d "1.49.2" /f

for /f "usebackq delims=" %%A in (`dir /b /a:d "%SYSTEMDRIVE%\Users" ^| findstr /v /i /x /c:"Public" /c:"Default User" /c:"All Users"`) do (
	echo 	PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%PUBLIC%\Desktop\Chromium.lnk'); $S.TargetPath = '%ProgramData%\chocolatey\bin\chrome.exe'; $S.IconLocation = '%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico'; $S.Save()"
	PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%PUBLIC%\Desktop\Chromium.lnk'); $S.TargetPath = '%ProgramData%\chocolatey\bin\chrome.exe'; $S.IconLocation = '%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico'; $S.Save()"

	copy /y "%PUBLIC%\Desktop\Chromium.lnk" "%SYSTEMDRIVE%\Users\%%A\AppData\Roaming\OpenShell\Pinned"
)

PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%ProgramData%\chocolatey\lib\ungoogled-chromium\Chromium.lnk'); $S.TargetPath = '%ProgramData%\chocolatey\bin\chrome.exe'; $S.IconLocation = '%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico'; $S.Save()"
PowerShell -NoP -C "$Content = (Get-Content '%~dp0\Layout.xml'); $Content = $Content -replace '%%ALLUSERSPROFILE%%\\Microsoft\\Windows\\Start Menu\\Programs\\Firefox.lnk', '%ProgramData%\chocolatey\lib\ungoogled-chromium\Chromium.lnk' | Set-Content '%~dp0\Layout.xml'"

for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	reg query "HKU\%%A" | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > NUL 2>&1
		if not errorlevel 1 (
			if "%%A"=="AME_UserHive_Default" (
				call :AFISCALL "%SYSTEMDRIVE%\Users\Default\AppData\Roaming" "%%A"
			) else (
				for /f "usebackq tokens=2* delims= " %%B in (`reg query "HKU\%%A\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "AppData" 2^>^&1 ^| findstr /R /X /C:".*AppData[ ]*REG_SZ[ ].*"`) do (
					call :AFISCALL "%%C" "%%A"
				)
			)
	)
)
exit /b 0

:AFISCALL

setlocal

if not "%~2"=="AME_UserHive_Default" (
	del "%~1\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Chromium.lnk" /q /f
	PowerShell -NoP -C "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%~1\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Chromium.lnk'); $S.TargetPath = '%ProgramData%\chocolatey\bin\chrome.exe'; $S.IconLocation = '%ProgramData%\chocolatey\lib\ungoogled-chromium\chromium.ico'; $S.Save()"

	reg add "HKU\%~2\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "Favorites" /t REG_BINARY /d "00A40100003A001F80C827341F105C1042AA032EE45287D668260001002600EFBE12000000B938E4724DEFD801B773BC9C4DEFD8017514D99C4DEFD801140056003100000000006355AC3311005461736B42617200400009000400EFBE6355AC336355AC332E0000002C9D01000000010000000000000000000000000000008B2592005400610073006B00420061007200000016001201320097010000874F0749200046494C4545587E312E4C4E4B00007C0009000400EFBE6355AC336355AC332E000000309D0100000001000000000000000000520000000000589C4400460069006C00650020004500780070006C006F007200650072002E006C006E006B00000040007300680065006C006C00330032002E0064006C006C002C002D003200320030003600370000001C00120000002B00EFBED66CDB9C4DEFD8011C00420000001D00EFBE02004D006900630072006F0073006F00660074002E00570069006E0064006F00770073002E004500780070006C006F0072006500720000001C00260000001E00EFBE0200530079007300740065006D00500069006E006E006500640000001C000000008A0100003A001F80C827341F105C1042AA032EE45287D668260001002600EFBE12000000B938E4724DEFD801B773BC9C4DEFD80122CF36A0D490D90114005600310000000000BB565B9E11005461736B42617200400009000400EFBE6355AC33BB565C9E2E0000002C9D0100000001000000000000000000000000000000AD4EAB005400610073006B0042006100720000001600F80032000C090000BB566E9E20004368726F6D69756D2E6C6E6B00004A0009000400EFBEBB566E9EBB566E9E2E0000004FA80100000005000000000000000000000000000000E92A09004300680072006F006D00690075006D002E006C006E006B0000001C00220000001E00EFBE02005500730065007200500069006E006E006500640000001C00120000002B00EFBE22CF36A0D490D9011C005E0000001D00EFBE020043003A005C00500072006F006700720061006D0044006100740061005C00630068006F0063006F006C0061007400650079005C00620069006E005C006300680072006F006D0065002E0065007800650000001C000000FF" /f
	reg add "HKU\%~2\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "FavoritesResolve" /t REG_BINARY /d "320300004C0000000114020000000000C0000000000000468300800020000000964FD49C4DEFD801D66CDB9C4DEFD801A8B6C6DADDACD501970100000000000001000000000000000000000000000000A0013A001F80C827341F105C1042AA032EE45287D668260001002600EFBE12000000B938E4724DEFD801B773BC9C4DEFD8017514D99C4DEFD801140056003100000000006355AC3311005461736B42617200400009000400EFBE6355AC336355AC332E0000002C9D01000000010000000000000000000000000000008B2592005400610073006B00420061007200000016000E01320097010000874F0749200046494C4545587E312E4C4E4B00007C0009000400EFBE6355AC336355AC332E000000309D0100000001000000000000000000520000000000589C4400460069006C00650020004500780070006C006F007200650072002E006C006E006B00000040007300680065006C006C00330032002E0064006C006C002C002D003200320030003600370000001C00220000001E00EFBE02005500730065007200500069006E006E006500640000001C00120000002B00EFBED66CDB9C4DEFD8011C00420000001D00EFBE02004D006900630072006F0073006F00660074002E00570069006E0064006F00770073002E004500780070006C006F0072006500720000001C0000009B0000001C000000010000001C0000002D000000000000009A00000011000000030000000522C56C1000000000433A5C55736572735C757365725C417070446174615C526F616D696E675C4D6963726F736F66745C496E7465726E6574204578706C6F7265725C517569636B204C61756E63685C557365722050696E6E65645C5461736B4261725C46696C65204578706C6F7265722E6C6E6B000060000000030000A058000000000000006465736B746F702D666268387633650014B5BC69C2059D439B4347F5B6C63660A421C645405BED118152000C2923D22B14B5BC69C2059D439B4347F5B6C63660A421C645405BED118152000C2923D22B45000000090000A03900000031535053B1166D44AD8D7048A748402EA43D788C1D000000680000000048000000A3E237A16911924EA5DFB5374E1DB68A000000000000000000000000170300004C0000000114020000000000C000000000000046830080002000000022CF36A0D490D90122CF36A0D490D901177534A0D490D9010C09000000000000010000000000000000000000000000008A013A001F80C827341F105C1042AA032EE45287D668260001002600EFBE12000000B938E4724DEFD801B773BC9C4DEFD80122CF36A0D490D90114005600310000000000BB565B9E11005461736B42617200400009000400EFBE6355AC33BB565C9E2E0000002C9D0100000001000000000000000000000000000000AD4EAB005400610073006B0042006100720000001600F80032000C090000BB566E9E20004368726F6D69756D2E6C6E6B00004A0009000400EFBEBB566E9EBB566E9E2E0000004FA80100000005000000000000000000000000000000E92A09004300680072006F006D00690075006D002E006C006E006B0000001C00220000001E00EFBE02005500730065007200500069006E006E006500640000001C00120000002B00EFBE22CF36A0D490D9011C005E0000001D00EFBE020043003A005C00500072006F006700720061006D0044006100740061005C00630068006F0063006F006C0061007400650079005C00620069006E005C006300680072006F006D0065002E0065007800650000001C000000960000001C000000010000001C0000002D000000000000009500000011000000030000000522C56C1000000000433A5C55736572735C757365725C417070446174615C526F616D696E675C4D6963726F736F66745C496E7465726E6574204578706C6F7265725C517569636B204C61756E63685C557365722050696E6E65645C5461736B4261725C4368726F6D69756D2E6C6E6B000060000000030000A058000000000000006465736B746F702D666268387633650014B5BC69C2059D439B4347F5B6C636607BB96DAAC4FCED118159000C292F898514B5BC69C2059D439B4347F5B6C636607BB96DAAC4FCED118159000C292F898545000000090000A03900000031535053B1166D44AD8D7048A748402EA43D788C1D000000680000000048000000A3E237A16911924EA5DFB5374E1DB68A000000000000000000000000" /f
)