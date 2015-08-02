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
    $name = $_."����"
    $Out = New-Object PSObject |
      Add-Member noteproperty "�c��" $null -pass |
      Add-Member noteproperty "���O" $null -pass |
      Add-Member noteproperty "�d�b" $null -pass |
      Add-Member noteproperty "�J�n��" $null -pass
    $Out.�d�b = $_."�d�b"
    $Out.�J�n�� = $_."�J�n��"
    $Out
  }                                 |
  ConvertTo-Csv                     |
  Out-File $out_csv -Encoding Default 

