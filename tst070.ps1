###############################################################################
#
# 連想配列への追加パフォーマンスの測定
# 連想配列に追加したmax件から、max/10件削除した後、全件出力の時間
# 連想配列に追加したmax件から、max/10件削除の印(0)を付けた後、全件読み、印以外を出力する時間
#
###############################################################################
Set-PSDebug -strict
$ErrorActionPreference = "Stop"

try {
  $max = 100000
  $h1 = @{}
  [String]::Format(" ハッシュへ{0}件データの追加", $max)
  $result = measure-command {
    1 .. $max |
      foreach-object {
        $h1[$(get-random $_).toString()] =  $_
      }
  }
  $result.TotalSeconds

  [String]::Format(" ハッシュへ{0}件データの削除(remove)", ($max/10))
  $result = measure-command {
    $count = 0
    1 .. ($max/10) |
      foreach-object {
        $h1.remove($(get-random $_).toString())
        $count += 1
      }
    [String]::Format('remove:{0}', $count) | write-host
  }
  $result.TotalSeconds

  [String]::Format(" ハッシュ全件処理")
  $result = measure-command {
    $count = 0
    foreach($key in $h1.keys) {
      $count += 1
    }
    [String]::Format('count:{0}', $count) | write-host
  }
  $result.TotalSeconds

  $h2 = @{}
  [String]::Format(" ハッシュへ{0}件データの追加", $max)
  $result = measure-command {
    1 .. $max |
      foreach-object {
        $h2[$(get-random $_).toString()] =  $_
      }
  }
  $result.TotalSeconds

  [String]::Format(" ハッシュへ{0}件データの削除(0)", ($max/10))
  $result = measure-command {
    $count = 0
    1 .. ($max/10) |
      foreach-object {
        $h2[$(get-random $_).toString()] = 0
        $count += 1
      }
    [String]::Format('remove:{0}', $count) | write-host
  }
  $result.TotalSeconds

  [String]::Format(" ハッシュ全件処理(0以外)")
  $result = measure-command {
    $count = 0
    foreach($key in $h2.keys) {
      if ($key -ne 0) {
        $count += 1
      }
    }
    [String]::Format('count:{0}', $count) | write-host
  }
  $result.TotalSeconds

} catch [Exception] {
  $error[0]
  exit 1
}
exit 0
