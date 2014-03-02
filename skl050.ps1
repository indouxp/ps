###############################################################################
# éûä‘ì¡íË
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
    [String]$t.Minutes + "ï™" + [String]$t.Seconds + "ïb" + [String]$t.Milliseconds
  } catch [Exception] {
    # ÉGÉâÅ[èàóù
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
