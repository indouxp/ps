$str = $null
for ($i = 0; $i -lt 1024; $i++) {
  $str += "テストデータ"
}
"------------"
[String]::Format('ハッシュに代入する文字列の文字数:{0},バイト数:{1}', $str.length,
                  [System.Text.Encoding]::GetEncoding("Shift_Jis").GetByteCount($str))
"------------"

function run {
  $hash = @{} # ハッシュの初期化
  $j = 0      # カウンター
  $k = 0      # ブレイクカウンター
  $watch = New-Object System.Diagnostics.StopWatch
  $watch.Start()
  while ($true) {
    $key = [String]::Format('key{0,00000}', $j) # 8byteのキー
    $hash.add($key, $str)                       # ハッシュへの追加
    if ($k -eq 1023) {
      $count = 0
      $total = 0
      foreach ($key in $hash.keys) {
        $count += 1
        $total += $hash[$key].length
      }
      $t = $watch.ElapsedMilliseconds
      [String]::Format('ハッシュの個数:{0}, 文字数:{1} -- {2}ミリ秒', $count, $total, $t)
      $k = 0
    }
    $j += 1 # カウンター
    $k += 1 # ブレイクカウンター
  }
}

try {
  run
} catch [Exception] {
  $error[0]
  exit 9
}
exit 0
