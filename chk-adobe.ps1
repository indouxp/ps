# Adobe

$pdf = "C:\Users\indou\Pictures\Å‹­ƒpƒ“ƒ`—˜_‹ZpŠv–½•Ò.pdf"
$Word = New-Object -comobject word.Application
$Doc = $Word.Documents.Open($pdf)

$Doc | get-member

