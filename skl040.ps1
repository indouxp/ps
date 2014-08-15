###############################################################################
#
#
###############################################################################
Param(
  [string]$filePath
)

function Main {
  Param(
    [string]$filePath
  )
  if ($filePath -ne "") {
    if ($filePath -match "^\.") {
      Write-Host "相対パス"
    } else {
      Write-Host "絶対パス"
    }
  }

}

Main $filePath
exit 0
