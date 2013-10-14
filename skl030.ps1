###############################################################################
# タブをフィールドセパレーターとしたファイルを読み込み、エクセルシートを作成
#
#
###############################################################################
Param(
  [string]$txtPath,
  [string]$logPath = $MyInvocation.MyCommand.Path + ".log"
)
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
[int32]$rc = 0
###############################################################################
function main {
  #try {
    toLog("START")
    # 処理
    chkTxtPath($txtPath)
    $recs = Get-Content -Path $txtPath
    $excel = New-Object -ComObject Excel.Application  # comオブジェクトの作成
    txtToExcel -ref_excel ([ref]$excel) -ref_recs ([ref]$recs)
    toLog("SUCCESS")
  #} catch [Exception] {
  #  # エラー処理
  #  toLog("ERROR:" + $_.Exception.Message)
  #  toLog("ERROR:" + $_.Exception.Source)
  #  toLog("ERROR:" + $_.Exception.StackTrace)
  #  $_.Exception | get-member
  #  exit $rc
  #} finally {
    $excel.quit() 
    toLog("DONE")
  #}
  exit $rc
}
###############################################################################
function txtToExcel {
  Param(
    [ref]$ref_excel,
    [ref]$ref_recs
  )
  $workbook = $ref_excel.Value.Workbooks.add(1)     # シート追加
  $sheet = $workbook.WorkSheets.Item(1)
  $sheet.Name = $MyName                             # シート名
  $excel.visible = $false
  $recs = $ref_recs.Value
  for ($row = 0; $row -lt $recs.Length; $row++) {
    Write-Host $row $recs[$row]
    $fields = $recs[$row] -split " +"               # / +/でsplit
    for ($col = 0; $col -lt $fields.Length; $col++) {
      $sheet.Cells.Item($row+1, $col+1) = $fields[$col]
    }    
  }
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
function toLog {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%dT%H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File $script:$logPath -encoding Default -append
}
###############################################################################
Set-PSDebug -strict
main
