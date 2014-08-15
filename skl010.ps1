###############################################################################
# ログを出力するサンプル
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
$ErrorActionPreference = "Stop"
trap {
	$Error
}
###############################################################################
function main {
  try {
    toLog "START"
    # 処理
    Start-Sleep 1
    "直接出力" | Out-File $script:$logPath -encoding Default -append
    toLog "SUCCESS"
  } catch [Exception] {
    # エラー処理
    toLog "ERROR:" + $Error
    exit 1
  } finally {
    toLog "DONE"
  }
  exit 0
}
###############################################################################
function toLog {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%dT%H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File $script:$logPath -encoding Default -append -ErrorAction Stop
}
###############################################################################
Set-PSDebug -strict
main
