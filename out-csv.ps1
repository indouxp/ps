
try {
  set-psdebug -strict # 変数初期化の強制
  $content = get-content -Path ./out-csv.csv | ConvertFrom-CSV
  #$content = import-csv -Path ./out-csv.csv -Encoding Default  # Power Shell Ver3以降
  $content.GetType()
  $content | get-member
  $content
} catch [exception] {
  write-error $Error[0]
  write-error ("InvocationInfo.Line:" + $Error[0].InvocationInfo.Line)
  write-error ("InvocationInfo.PositionMessage:" + $Error[0].InvocationInfo.PositionMessage)
  exit 1
} finally {
  set-psdebug -off  # 変数初期化の強制OFF
  exit 0
}
