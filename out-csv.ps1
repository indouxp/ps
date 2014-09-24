try {
  set-psdebug -strict # 変数初期化の強制
  $content = get-content -Path ./out-csv.csv | ConvertFrom-CSV
  $content
} catch [exception] {
  write-error $Error[0]
  write-error ("InvocationInfo.Line:" + $Error[0].InvocationInfo.Line)
  write-error ("InvocationInfo.PositionMessage:" + $Error[0].InvocationInfo.PositionMessage)
  exit 1
} finally {
  set-psdebug -off
  exit 0
}
