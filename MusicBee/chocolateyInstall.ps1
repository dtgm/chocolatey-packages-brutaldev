﻿$packageName = "musicbee"
$zipFile = "MusicBeeSetup_2_4.zip"
$exeFile = "MusicBeeSetup_2_4.exe"
$url = "http://musicbee.niblseed.com/$zipFile"
$url64 = $url
$silentArgs = "/S"
$validExitCodes = @(0)

try { 
  $chocTempDir = Join-Path $env:TEMP "chocolatey"
  $tempDir = Join-Path $chocTempDir "$packageName"
  if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
  $file = Join-Path $tempDir $zipFile
          
  Get-ChocolateyWebFile $packageName $file $url $url64
  Get-ChocolateyUnzip $file $tempDir "" $packageName

  $file = Join-Path $tempDir $exeFile

  Install-ChocolateyInstallPackage $packageName 'exe' $silentArgs $file -validExitCodes $validExitCodes

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}