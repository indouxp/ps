$str = $null
for ($i = 0; $i -lt 1024; $i++) {
  $str += "テストデータ"
}
"------------"
[String]::Format('配列に代入する文字列の文字数:{0},バイト数:{1}', $str.length,
                  [System.Text.Encoding]::GetEncoding("Shift_Jis").GetByteCount($str))
"------------"

function run {
  $arr = @()  # 配列初期化
  $j = 0      # カウンター
  $k = 0      # ブレイク
  $watch = New-Object System.Diagnostics.StopWatch
  $watch.Start()
  while ($true) {
    $arr += $str      # 配列に追加
    if ($k -eq 1023) {
      $k = 0
      $t = $watch.ElapsedMilliseconds
      [String]::Format('配列の個数:{0} -- {1}ミリ秒', $arr.count, $t)
    }
    $j += 1
    $k += 1
  }
}

try {
  run
} catch [Exception] {
  $error[0]
  exit 9
}
exit 0
