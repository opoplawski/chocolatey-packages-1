﻿. $PSScriptRoot\..\dbgate\update.ps1

$ErrorActionPreference = 'STOP'

function global:au_BeforeUpdate {
  $Latest.FileName64 = "$($Latest.FileName64Portable)"
  $Latest.Url64      = "$($Latest.Url64Portable)"
  $Latest.FileType   = 'zip'

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\README.md" = @{
      "$($reVersion)" = "$($Latest.Version)"
    }

    ".\legal\VERIFICATION.txt" = @{
      "$($reChecksum)" = "$($Latest.Checksum64)"
      "$($rePortable)" = "$($Latest.FileName64)"
      "$($reVersion)"  = "$($Latest.Version)"
    }

    ".\tools\chocolateyinstall.ps1" = @{
      "$($rePortable)" = "$($Latest.FileName64)"
    }
  }
}

update -ChecksumFor none -NoReadme
