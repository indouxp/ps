###############################################################################
# ���ԓ���
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
    [String]$t.Minutes + "��" + [String]$t.Seconds + "�b" + [String]$t.Milliseconds
  } catch [Exception] {
    # �G���[����
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
