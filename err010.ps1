param([int]$num = 0)
# 管理者権限で実行しないとだめ
# 例外発生時の処理を定義
trap [Exception] {
  # イベント・ログに書き込む
  [Diagnostics.EventLog]::WriteEntry("PowerShell Script", $error[0].exception, "Error", 1)
  exit 9
}

# 引数$numで除算した値を表示（引数$numが0の場合は例外発生）
10 / $num
"処理が終了しました。"
exit 0
