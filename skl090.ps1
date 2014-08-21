###############################################################################
# skl090.ps1
#
#
###############################################################################
Param(
  [string]$global:logPath = $MyInvocation.MyCommand.Path + ".log"
)
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
[string]$table = "tbl_messages"
###############################################################################
$ErrorActionPreference = "Stop"
trap {
  $msg = "TRAP:" + $Error[0]
	Write-Host $msg
  toLog $msg
	break
}
$CommonModule = $MyPath -replace $MyName, "cmn090.psm1"
Import-Module $CommonModule
$ScriptModule = $MyPath -replace "ps1", "psm1"
Import-Module $ScriptModule
Get-Module
###############################################################################
function main {
  try {
    toLog "START"
    # 処理
    $message = "テスト"
		insert_message -status 0 -facility "ps1" -priority 0 -message $message
		if ($?) {
    	toLog "SUCCESS"
		} else {
			throw "insert_message"
		}
  } catch [Exception] {
    # エラー処理
    $msg = "CATCH:" + $Error[0]
		Write-Host $msg
    toLog $msg
    exit 1
  } finally {
    toLog "DONE"
  }
  exit 0
}
###############################################################################
Set-PSDebug -strict
main
