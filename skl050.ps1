###############################################################################
# ���ԑ���
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
    [String]$t.Minutes + "��" + [String]$t.Seconds + "�b" + [String]$t.Milliseconds
  } catch [Exception] {
    # �G���[����
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
