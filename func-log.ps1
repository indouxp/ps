###############################################################################
# ÉçÉOèoóÕ
function toLog {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%d_%H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File $script:$logPath -encoding Default -append
}
