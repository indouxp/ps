###############################################################################
#
#
#
###############################################################################
#
$in_csv = "in.csv"
$out_csv = "out.csv"

Get-Content $in_csv -Encoding UTF8  |
  ConvertFrom-Csv                   |
  ForEach-Object {
    $name = $_."氏名"
    $Out = New-Object PSObject |
      Add-Member noteproperty "苗字" $null -pass |
      Add-Member noteproperty "名前" $null -pass |
      Add-Member noteproperty "電話" $null -pass |
      Add-Member noteproperty "開始日" $null -pass
    $Out.電話 = $_."電話"
    $Out.開始日 = $_."開始日"
    $Out
  }                                 |
  ConvertTo-Csv                     |
  Out-File $out_csv -Encoding Default 

