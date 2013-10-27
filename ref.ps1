###############################################################################
# 関数への参照渡しでの呼び出しサンプル
###############################################################################
function main {
  $names = @()
  $files = get-childitem

  # パラメータ名を指定しない
  func ([ref]$files) ([ref]$names) 
  # パラメータ名を指定する。
  func -ref_files ([ref]$files) -ref_names ([ref]$names)

  foreach ($name in $names) {
    $name
  }
}

function func {
  Param (
    [ref]$ref_files,
    [ref]$ref_names
  )
  foreach ($value in $ref_files.Value) {
    # $namesの配列への参照にファイル名のみを入れる
    $ref_names.Value += $value.Name
  }
}

Set-PSDebug -strict # 値が設定される前に変数が参照された場合に、インタープリターが例外をスローするように指定します。
main
