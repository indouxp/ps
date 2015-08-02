param($in_path)

set-variable -name high_value -value 0xFFFFFFFF -option constant

$in_path

function read1line {
  param([ref]$ref_fh, [ref]$ref_line)
  $ref_line.value = $ref_fh.value.readline()
  if ($ref_line.value -eq $null) {
    $ref_line.value = $high_value
  }
}

$enc = [Text.Encoding]::GetEncoding("Shift_JIS")
$fh = New-Object System.IO.StreamReader($in_path, $enc)
if ($fh -eq $null) {
  $error[0]
  exit
}
$line = $null
do {
  read1line -ref_fh ([ref]$fh) -ref_line ([ref]$line)
  $line
} until ($line -eq $high_value)
$fh.Close()
