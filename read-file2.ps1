###############################################################################
# �t�@�C������s���ɏo��
#
#
###############################################################################
Param(
  [string]$inFile
)

###############################################################################
$i=1
$enc = [Text.Encoding]::GetEncoding("Shift_JIS")
$fh = New-Object System.IO.StreamReader($inFile, $enc)
while (($line = $fh.ReadLine()) -ne $null) {
  Write-Host $i : $line
	$i++
}
$fh.close()

