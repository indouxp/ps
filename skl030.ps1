###############################################################################
# �^�u���t�B�[���h�Z�p���[�^�[�Ƃ����t�@�C����ǂݍ��݁A�G�N�Z���V�[�g���쐬
#
#
###############################################################################
Param(
  [string]$logPath = $MyInvocation.MyCommand.Path + ".log",
  [string]$txtPath
)
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
###############################################################################
function main {
  try {
    toLog("START")
    # ����
    if (Test-Path $txtPath) {
      toLog($txtPath)
    }
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
