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
function main {
  try {
    toLog("START")
    # ����
    Start-Sleep 5
    "���ڏo��" | Out-File $script:$logPath -encoding Default -append
    toLog("SUCCESS")
  } catch [Exception] {
    # �G���[����
    toLog("ERROR:" + $Error )
    exit 1
  } finally {
    toLog("DONE")
  }
  exit 0
}
###############################################################################
function toLog {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%dT%H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File $script:$logPath -encoding Default -append
}
###############################################################################
Set-PSDebug -strict
main
