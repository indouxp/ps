#
# http://blog.livedoor.jp/morituri/archives/53989603.html
# Windowsフォームのモーダルダイアログを表示する
#
Add-Type -AssemblyName System.Windows.Forms
$form1 = New-Object System.Windows.Forms.Form
$form1.ShowDialog()
