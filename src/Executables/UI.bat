@echo OFF

for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /c:"Classes"`) do (
		call :UICALL1 "%%A"
)

for /f "usebackq tokens=2 delims=\" %%A in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\\S-.*" /c:"HKEY_USERS\\AME_UserHive_[^_]*"`) do (
	reg query "HKU\%%A" | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > NUL 2>&1
		if not errorlevel 1 call :UICALL2 "%%A"
)

@exit /b 0


:UICALL1

@echo ON
:: Context Menu
reg add "HKU\%~1\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
reg add "HKU\%~1\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /t REG_SZ /d "" /f

:: File Explorer Command Bar
reg add "HKU\%~1\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}" /f
reg add "HKU\%~1\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32" /t REG_SZ /d "" /f

:: Old Explorer Search
reg add "HKU\%~1\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}" /f
reg add "HKU\%~1\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}\TreatAs" /t REG_SZ /d "{64bc32b5-4eec-4de7-972d-bd8bd0324537}" /f

:: Taskbar Small Icons and Taskbar on the right side
reg add "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSmallIcons" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v "Settings" /t REG_BINARY /D "30000000feffffff02800000020000003e00000028000000420400000000000080040000600300006000000001000000" /f
@echo OFF
exit /b 0

:UICALL2

@echo ON
reg add "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_ShowClassicMode" /t REG_DWORD /D 1 /f

reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "OldTaskbar" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "UpdatePolicy" /t REG_DWORD /D 2 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "EnableSymbolDownload" /t REG_DWORD /D 0 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "HideControlCenterButton" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "StartDocked_DisableRecommendedSection" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "TaskbarGlomLevel" /t REG_DWORD /D 2 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "MMTaskbarGlomLevel" /t REG_DWORD /D 2 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "OrbStyle" /t REG_DWORD /D 1 /f

reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "FileExplorerCommandUI" /t REG_DWORD /D 2 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "StartUI_EnableRoundedCorners" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher" /v "StartUI_EnableRoundedCorners" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "ClockFlyoutOnWinC" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "DisableOfficeHotkeys" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "DisableWinFHotkey" /t REG_DWORD /D 1 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "DoNotRedirectProgramsAndFeaturesToSettingsApp" /t REG_DWORD /D 1 /f

reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "HideIconAndTitleInExplorer" /t REG_DWORD /D 3 /f
reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "IMEStyle" /t REG_DWORD /D 4 /f

reg add "HKU\%~1\SOFTWARE\ExplorerPatcher" /v "MicaEffectOnTitlebar" /t REG_DWORD /D 1 /f

reg add "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f
reg add "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f
@echo OFF
exit /b 0