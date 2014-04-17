#
# csvファイルからExcelブックを作成する
#
$pwd = (Get-Location).ToString()
$csvpath=$pwd + '\' + 'csv2excel.csv'

$xl = New-Object -ComObject Excel.Application
$wb = $xl.workbooks.open($csvpath)
$xlout = $csvpath.Replace('.csv', '.xlsx') 
$wb.SaveAs($xlOut, 51) 
$xl.Quit()

