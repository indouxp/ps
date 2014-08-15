###############################################################################
# システムの情報を取得し、Excel、bookを作成する。
# http://ebi.dyndns.biz/windowsadmin/2012/01/15/powershell%E3%81%A7os%E3%81%AE%E5%9F%BA%E6%9C%AC%E6%83%85%E5%A0%B1%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B/
#
###############################################################################
Param(
  [string]$bookPath = $MyInvocation.MyCommand.Path + ".xlsx"
)
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
###############################################################################
$ErrorActionPreference = "Stop"
trap {
  $msg = "trap:" + $Error[0]
  $msg
	break
}
###############################################################################
function main {
  try {
    $rc = 0
    $excel = New-Object -ComObject Excel.Application  # comオブジェクトの作成
    $workbook = $excel.Workbooks.add(1)               # シート追加
    $sheet = $workbook.WorkSheets.Item(1)
    $sheet.Name = $MyName                             # シート名
    $excel.visible = $false
    report([ref]$sheet)
    Start-Sleep 5
    $excel.DisplayAlerts = $false
    $workbook.SaveAs($bookPath)
  } catch [Exception] {
    # エラー処理
    $msg = "catch:" + $Error[0]
		$msg
    exit 1
  } finally {
    $excel.DisplayAlerts = $false
    $excel.quit() 
  }
  exit $rc
}
###############################################################################
function report([ref]$ref_sheet) {
  [int32]$row = 1

  $ref_sheet.Value.Cells.Item($row, 1) = "hostname"
  $ref_sheet.Value.Cells.Item($row, 2) = hostname
  $row++

  $ref_sheet.Value.cells.Item($row, 1) = "OS Version"
  $ref_sheet.Value.cells.Item($row, 2) = [Environment]::OSVersion 
  $row++

  $ref_sheet.Value.cells.Item($row, 1) = "Disk"
  $recs = Get-WmiObject -Class Win32_DiskDrive
  foreach ($rec in $recs) {
    $ref_sheet.Value.cells.Item($row, 2) = $rec.Name
    $row++
    $members = $rec | Get-Member -MemberType Property
    foreach ($member in $members) {
      $ref_sheet.Value.Cells.Item($row, 3) = $member.Name
      try {
        $ref_sheet.Value.Cells.Item($row, 4) = $rec[$member.Name]
      } catch [Exception] {
        Write-Host "Disk"
        Write-Host $rec
        Write-Host $member.Name
        Write-Host $Error
        continue
      }
      $row++
    }
  }

  $ref_sheet.Value.cells.Item($row, 1) = "Network"
  $recs = Get-WmiObject Win32_NetworkAdapterConfiguration
  foreach ($rec in $recs) {
    $ref_sheet.Value.cells.Item($row, 2) = $rec.Name
    $row++
    $members = $rec | Get-Member -MemberType Property
    foreach ($member in $members) {
      $ref_sheet.Value.Cells.Item($row, 3) = $member.Name
      try {
        $ref_sheet.Value.Cells.Item($row, 4) = $rec[$member.Name]
      } catch [Exception] {
        Write-Host "Network"
        Write-Host $rec
        Write-Host $member.Name
        Write-Host $Error
        continue
      }
      $row++
    }
  }

  $ref_sheet.Value.cells.Item($row, 1) = "Patch"
  $recs = Get-WMIObject Win32_QuickFixEngineering
  foreach ($rec in $recs) {
    $ref_sheet.Value.cells.Item($row, 2) = $rec.Name
    $row++
    $members = $rec | Get-Member -MemberType Property
    foreach ($member in $members) {
      $ref_sheet.Value.Cells.Item($row, 3) = $member.Name
      try {
        $ref_sheet.Value.Cells.Item($row, 4) = $rec[$member.Name]
      } catch [Exception] {
        Write-Host "Network"
        Write-Host $rec
        Write-Host $member.Name
        Write-Host $Error
        continue
      }
      $row++
    }
  }

  $range = $ref_sheet.Value.usedRange
  $range.EntireColumn.AutoFit() | out-null
}
###############################################################################
Set-PSDebug -strict
main
