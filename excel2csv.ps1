#
# ExcelÉVÅ[ÉgÇ©ÇÁcsvÇçÏê¨
#
$xl = New-Object -ComObject Excel.Application
$xlCSV = 6

$pwd = (Get-Location).ToString()
$xlsxpath=$pwd + "\" + "excel2csv.xlsx"
$csv_prefix=$pwd + "\" + "excel2csv-"
$wb = $xl.Workbooks.Open($xlsxpath)

$i = 0
foreach($sheet in $wb.Sheets){
  $sheet.Select()
  $wb.SaveAs($csv_prefix + $i + ".csv", $xlCSV)
  $i += 1
}
$wb.Close()
$xl.Quit()

