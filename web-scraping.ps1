$data = Invoke-WebRequest -Uri "https://www.google.co.jp/trends/"
$data.get_AllElements() |
#where-Object {
#  $_.class -eq "hottrends-single-trend-title"
#} |
ForEach-Object {
  Write-Output $_.class $_.InnerText
}
