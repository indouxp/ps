###############################################################################
# 時間特定
#
#
###############################################################################
###############################################################################
function main {
  try {
    "START"
    $watch = New-Object System.Diagnostics.StopWatch
    $watch.Start()
    Start-Sleep 2
    $watch.Stop()
    $t = $watch.Elapsed
    [String]$t.Minutes + "分" + [String]$t.Seconds + "秒" + [String]$t.Milliseconds
  } catch [Exception] {
    # エラー処理
    $Error
    exit 1
  } finally {
    "DONE"
  }
  exit 0
}
###############################################################################
Set-PSDebug -strict
main
