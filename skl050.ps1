###############################################################################
# 時間測定
#
#
###############################################################################
trap {
  $msg = "trap:" + $Error[0]
  $msg
	break
}
###############################################################################
function main {
  try {
    "START"
    $watch = New-Object System.Diagnostics.StopWatch
    $watch.Start()
    Start-Sleep -m 2434
    $watch.Stop()
    $t = $watch.Elapsed
    [String]$t.Minutes + "分" + [String]$t.Seconds + "秒" + [String]$t.Milliseconds
  } catch [Exception] {
    # エラー処理
    $msg = "catch:" + $Error[0]
    $msg
    exit 1
  } finally {
    "DONE"
  }
  exit 0
}
###############################################################################
Set-PSDebug -strict
main
