###############################################################################
# ���O���o�͂���T���v��
#
#
###############################################################################
Param(
  [string]$logPath = $MyInvocation.MyCommand.Path + ".log"
)
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
###############################################################################
function toLog {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%d %H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File $script:$logPath -encoding Default -append
}
###############################################################################
try {
  toLog("START")
  # ����
  Start-Sleep 5
  "job" | Out-File "c:\notexist\test.txt"
  toLog("SUCCESS")
} catch [Exception] {
  # �G���[����
  toLog("ERROR:" + $Error )
  exit 1
} finally {
  toLog("DONE")
}
exit 0
