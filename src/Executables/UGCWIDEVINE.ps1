# https://chromium.woolyss.com/#widevine

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

# make temp directories
$rootTemp = Join-Path -Path $env:TEMP -ChildPath $([System.IO.Path]::GetRandomFileName())
New-Item $rootTemp -ItemType Directory -Force | Out-Null

# get latest version and download it
$latestVersion = (Invoke-RestMethod "https://dl.google.com/widevine-cdm/versions.txt" -UseBasicParsing) -split "`n" | ? {$_.Trim() -ne "" } | Select-Object -Last 1
Invoke-WebRequest "https://dl.google.com/widevine-cdm/$latestVersion-win-x64.zip" -OutFile "$rootTemp\widevine-ugc.zip" -UseBasicParsing
# extract to temp
Expand-Archive "$rootTemp\widevine-ugc.zip" -DestinationPath $rootTemp -Force

# copy to UGC
foreach ($user in $(Get-ChildItem "$env:SystemDrive\Users" -Force -Directory -Exclude "All Users", "Default User", "Public")) {
    $widevinePath = "$user\AppData\Local\Chromium\User Data\WidevineCdm\_platform_specific"

    New-Item @("$widevinePath\..", "$widevinePath") -Force -ItemType Directory
    Copy-Item "$rootTemp\*" -Destination $widevinePath -Recurse -Force -Include "*.dll*"
    Copy-Item "$rootTemp\*" -Destination "$widevinePath\.." -Recurse -Force -Exclude "*.zip", "*.dll*"
}