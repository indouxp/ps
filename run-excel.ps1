$xl = New-Object -ComObject Excel.Application # comオブジェクトの作成
$wf = $xl.WorksheetFunction
try {
  $wf.Average(@(1, 2, 3, 4, 5)) # 計算をする
} finally {
  $wf, $xl | ForEach {
    [void][Runtime.Interopservices.Marshal]::ReleaseComObject($_)
  }
}
