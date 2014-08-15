###############################################################################
# �^�u���t�B�[���h�Z�p���[�^�[�Ƃ����t�@�C����ǂݍ��݁A�G�N�Z���V�[�g���쐬
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
$ErrorActionPreference = "Stop"
trap {
  $msg = "trap:" + $Error[0]
	Write-Host $msg
  toLog $msg
	break
}
###############################################################################
# main
###############################################################################
function main {
  $excel = ""
  try {
    toLog("START")
    # ����
    chkTxtPath($txtPath)
    chkBookPath([ref]$bookPath)
    toConsole($txtPath)
    toConsole($bookPath)
    $recs = Get-Content -Path $txtPath                # txtPath�t�@�C���̓ǂݍ��݁��z��
    $excel = New-Object -ComObject Excel.Application  # com�I�u�W�F�N�g�̍쐬
    $excel.DisplayAlerts = $false
    $workbook = $excel.Workbooks.add(1)               # �V�[�g�ǉ�
    txtToWorkbook -ref_workbook ([ref]$workbook) -ref_recs ([ref]$recs)
    $workbook.SaveAs($bookPath)
    toLog("SUCCESS")
  } catch [Exception] {
    # �G���[����
    $msg = "catch:" + $Error[0]
		Write-Host $msg
    toLog $msg
    exit 1
  } finally {
    if ($excel -ne "") {
      $excel.quit() 
    }
    toLog("DONE")
  }
}
###############################################################################
# workbook�쐬
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
  $sheet.Name = $MyName                             # �V�[�g��
  $excel.visible = $false
  $recs = $ref_recs.Value
  for ($row = 0; $row -lt $recs.Length; $row++) {
    Write-Host $row $recs[$row]
    $fields = $recs[$row] -split "\t"
    for ($col = 0; $col -lt $fields.Length; $col++) {
      $sheet.Cells.Item($row+1, $col+1) = $fields[$col]
      if ($row -eq 0) {
        $sheet.cells.item($row+1,$col+1).font.bold = $true
        $sheet.cells.item($row+1,$col+1).borders.LineStyle = $lineStyle::xlContinuous
        $sheet.cells.item($row+1,$col+1).borders.ColorIndex = $colorIndex::xlColorIndexAutomatic
        $sheet.cells.item($row+1,$col+1).borders.weight = $borderWeight::xlMedium
      } else {
        $sheet.cells.item($row+1,$col+1).font.bold = $false
        $sheet.cells.item($row+1,$col+1).borders.LineStyle = $lineStyle::xlContinuous
        $sheet.cells.item($row+1,$col+1).borders.ColorIndex = $colorIndex::xlColorIndexAutomatic
        $sheet.cells.item($row+1,$col+1).borders.weight = $borderWeight::xlMedium
      }
    }    
  }
  $range = $sheet.usedRange
  $range.EntireColumn.AutoFit() | out-null
}
###############################################################################
# txtPath�̃`�F�b�N
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
# bookPath�̃`�F�b�N
###############################################################################
function chkBookPath {
  Param([ref]$ref_bookPath)
  if ($ref_bookPath.Value -ne "") {
    if ($ref_bookPath.Value -match "^\.\\") {
      $pwd = Get-Location
      $ref_bookPath.Value = $ref_bookPath.Value -replace "^\.", $pwd.Path
    }
    toLog($ref_bookPath.Value)
  } else {
    $rc = 1
    throw "txtPath not set"
  }
}
###############################################################################
# �R���\�[���o��
###############################################################################
function toConsole {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%dT%H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Add-Content -Path $script:$logPath
}
###############################################################################
# ���O��������
###############################################################################
function toLog {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%dT%H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File $script:$logPath -encoding Default -append
}
###############################################################################
# ���s����
###############################################################################
Set-PSDebug -strict
main
exit $rc
