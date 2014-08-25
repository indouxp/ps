###############################################################################
#
#
#
###############################################################################
param($inFile)
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
#[string]$logName = $MyInvocation.MyCommand.Name  + "." + (date -uFormat "%Y%m%d.%H%M%S")  +  ".log"
[string]$logName = $MyInvocation.MyCommand.Name  + ".log"
[string]$logPath = Join-Path "D:\Data\Logs" $logName
###############################################################################
. ~\utils\cmn010.ps1
$envFile = Join-Path (Split-Path $MyPath -Parent) "tsystem.ps1"
. $envFile
###############################################################################
$ErrorActionPreference = "Stop"
trap {
  $msg = "TRAP:" + $Error[0]
	Write-Error $msg
  add2Log $msg
	break
}
###############################################################################
function main {
  try {
    add2Log "START"
    add2Log "IN:$inFile"
		if (-not(Test-Path $inFile)) {
			add2Log "NOT EXISTS:$inFile"
		}
		[string]$sqlFile = Join-Path "D:\Data\tmp" ((Split-Path -Leaf $inFile) -Replace ".csv", ".sql")
		[string]$sqlLogFile = $sqlFile -Replace ".sql", ".log"
		add2Log "SQL:$sqlFile"
		add2Log "LOG:$sqlLogFile"
		if (Test-Path $sqlFile) {
			remove-item $sqlFile
		}
		$sql = @"
			delete from tbl_item
"@
		New-Item -Type file -Path $sqlFile > $null
		Add-Content -Path $sqlFile -Value $sql -Encoding String
		Get-Content $inFile | ConvertFrom-Csv | Sort-Object item_code |
			ForEach-Object {
				"insert into tbl_item (item_code, item_name, remark) values (" + 
				"'" + $_.item_code + "', " +
				"'" + $_.item_name + "', " + 
				"'" + $_.remark + "')"
			} | Out-File -Append $sqlFile -Encoding Default
		Add-Content -Path $sqlFile -Value "go" -Encoding String
		sqlcmd -E -S $global:serverName -d $global:database -i $sqlFile -u -b -w 80 -W -o $sqlLogFile
		if ($? -ne $true) {
			throw "sqlcmd: FAIL"
		}
    add2Log "SUCCESS"
  } catch [Exception] {
    # ÉGÉâÅ[èàóù
		add2Log ("CATCH:" + $Error[0])
		add2Log ("InvocationInfo.Line:" + $Error[0].InvocationInfo.Line)
    add2Log ("InvocationInfo.PositionMessage:" + $Error[0].InvocationInfo.PositionMessage)
    exit 1
  } finally {
    add2Log "DONE"
  }
  exit 0
}
###############################################################################
Set-PSDebug -strict
main
