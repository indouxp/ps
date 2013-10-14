###############################################################################
# タブをフィールドセパレーターとしたファイルを読み込み、エクセルシートを作成
#
#
###############################################################################
Param(
  [string]$txtPath,
  [string]$bookPath,
  [string]$logPath = $MyInvocation.MyCommand.Path + ".log"
)
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
[int32]$rc = 0
###############################################################################
function main {
  try {
    toLog("START")
    # 処理
    chkTxtPath($txtPath)
    chkBookPath($bookPath)
    $recs = Get-Content -Path $txtPath
    $excel = New-Object -ComObject Excel.Application  # comオブジェクトの作成
    $workbook = $excel.Workbooks.add(1)               # シート追加
    txtToWorkbook -ref_workbook ([ref]$workbook) -ref_recs ([ref]$recs)
    $excel.DisplayAlerts = $false
    $workbook.SaveAs($bookPath)
    toLog("SUCCESS")
  } catch [Exception] {
    # エラー処理
    toLog("ERROR:" + $_.Exception.Message)
    exit $rc
  } finally {
    $excel.quit() 
    toLog("DONE")
  }
  exit $rc
}
###############################################################################
function txtToWorkbook {
  Param(
    [ref]$ref_workbook,
    [ref]$ref_recs
  )
  $lineStyle    = "microsoft.office.interop.excel.xlLineStyle" -as [type]
  $colorIndex   = "microsoft.office.interop.excel.xlColorIndex" -as [type]
  $borderWeight = "microsoft.office.interop.excel.xlBorderWeight" -as [type]
  $chartType    = "microsoft.office.interop.excel.xlChartType" -as [type]

  $workbook = $ref_workbook.Value
  $sheet = $workbook.WorkSheets.Item(1)
  $sheet.Name = $MyName                             # シート名
  $excel.visible = $false
  $recs = $ref_recs.Value
  for ($row = 0; $row -lt $recs.Length; $row++) {
    Write-Host $row $recs[$row]
    $fields = $recs[$row] -split " +"               # / +/でsplit
    for ($col = 0; $col -lt $fields.Length; $col++) {
      $sheet.Cells.Item($row+1, $col+1) = $fields[$col]
      if ($row -eq 0) {
        $sheet.cells.item($row+1,$col+1).font.bold = $true
        $sheet.cells.item($row+1,$col+1).borders.LineStyle = $lineStyle::xlDashDot
        $sheet.cells.item($row+1,$col+1).borders.ColorIndex = $colorIndex::xlColorIndexAutomatic
        $sheet.cells.item($row+1,$col+1).borders.weight = $borderWeight::xlMedium
      }
    }    
  }
  $range = $ref_sheet.Value.usedRange
  $range.EntireColumn.AutoFit() | out-null
}
###############################################################################
function chkTxtPath {
  Param([string]$txtPath)
  if ($txtPath -ne "") {
    if (Test-Path $txtPath) {
      toLog($txtPath)
    } else {
      $rc = 1
      throw "$txtPath not exist"
    }
  } else {
    $rc = 1
    throw "txtPath not set"
  }
}
###############################################################################
function chkBookPath {
  Param([string]$bookPath)
  if ($bookPath -ne "") {
    toLog($bookPath)
  } else {
    $rc = 1
    throw "txtPath not set"
  }
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
