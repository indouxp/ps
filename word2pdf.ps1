
$Word = New-Object -comobject word.Application

[string]$dirname = (Split-Path $MyInvocation.MyCommand.Path -parent)
[string]$docx = $dirname + "\" + "test.docx"
[string]$pdf = $dirname + "\" + "test.pdf"

$Doc=$Word.Documents.Open($docx)

$Doc.SaveAs($pdf, 17)

