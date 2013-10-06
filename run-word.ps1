$fn = "utf8.txt"
$text = [String]::Join("`n", (get-content -encoding UTF8 $fn))

$word = new-object -comObject "Word.Application"
$word.Visible = $true

$doc = $word.Documents.Add()

$range = $doc.Content
$range.Text = $text

$doc.CheckGrammar()
