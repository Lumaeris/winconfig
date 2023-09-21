<# : batch portion
@echo off & powershell -nop Get-Content "%~f0" -Raw ^| iex & exit /b
: end batch / begin PowerShell #>

Set-StrictMode -Off

if (Get-Command "NanaZipC.exe" -ErrorAction SilentlyContinue) {
	$cmd = "nanazipc"
} elseif (Get-Command "7z.exe" -ErrorAction SilentlyContinue) {
	$cmd = "7z"
} elseif ([System.IO.File]::Exists("%PROGRAMFILES%\7-Zip\7z.exe")) {
	$cmd = "%PROGRAMFILES%\7-Zip\7z.exe"
} else {
	[console]::error.writeline("This script is only adapted for use with 7-Zip or NanaZip installed.")
    pause
	exit 1
}

& $cmd "a" "-pmalte" "-t7z" "-m0=lzma2" "-mx=9" "-mfb=64" "-md=32m" "-ms=on" "winconfig-0.5+lumaeris.1.apbx" "../src/*"
