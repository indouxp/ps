###############################################################################
# ファイルを一行毎に出力
#
#
###############################################################################
Param(
  [string]$inFile
)

###############################################################################
$f = (Get-Content $inFile) -as [string[]]
$i=1
foreach ($l in $f) {
	Write-Host $i : $l
	$i++
}
