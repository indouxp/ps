
$script:basename = $MyInvocation.MyCommand.Name
. (join-path (split-path $MyInvocation.MyCommand.Path -parent) "sub0.ps1")

try {
  "開始" | write-log
  start-sleep 1
  "終了" | write-log
} catch [exception] {
  "異常終了" | write-log
} finally {
  "最後" | write-log
}
