#
# http://blog.livedoor.jp/morituri/archives/53989603.html
# Windowsフォームのモーダルダイアログを表示する
#
Add-Type -AssemblyName System.Windows.Forms

$form1 = New-Object System.Windows.Forms.Form

$input1 = New-Object System.Windows.Forms.TextBox
$form1.Controls.Add($input1)

$btnok = New-Object System.Windows.Forms.Button
$btnok.Text = "OK"
$btnok.Top = $input1.Height + 1
$form1.Controls.Add($btnok)

$form1.ShowDialog()
