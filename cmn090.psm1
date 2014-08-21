###############################################################################
# cmn090.psm1 
#
#
###############################################################################
[string]$global:server_name = ".\sqlexpress"
[string]$global:database = "tsystem"
function toLog {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%d-%H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File $global:logPath -encoding Default -append -ErrorAction Stop
}
###############################################################################
