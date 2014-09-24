# http://www.atmarkit.co.jp/fwin2k/win2ktips/992callwsh/callwsh.html
# ScriptControlオブジェクトで実行するスクリプトを定義
param([string]$msg)
$src = .\ScriptControl.ps1
$src.showmessage($msg)
