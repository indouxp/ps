# Adobe

$pdf = "C:\Users\indou\Pictures\�ŋ��p���`���_�Z�p�v����.pdf"
$Word = New-Object -comobject word.Application
$Doc = $Word.Documents.Open($pdf)

$Doc | get-member

