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
      Write-Host "���΃p�X"
    } else {
      Write-Host "��΃p�X"
    }
  }

}

Main $filePath
exit 0
