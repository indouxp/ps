# http://www.atmarkit.co.jp/fwin2k/win2ktips/992callwsh/callwsh.html
# ScriptControlオブジェクトで実行するスクリプトを定義
$prog = '
  Function ShowMessage(ByVal msg)
    MsgBox(msg)
  End Function
'
# ScriptControlオブジェクトを生成
$ctrl = New-Object -ComObject ScriptControl
# 使用する言語を設定
$ctrl.Language = 'VBScript'
# スクリプト・コードを解析のうえで登録
$ctrl.AddCode($prog)
# 登録した関数を呼び出すためのCodeObjectオブジェクトを返す
$ctrl.CodeObject
