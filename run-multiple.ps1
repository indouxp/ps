Param($multiple_file_path)
###############################################################################
# $multiple_file_pathを読み込み、コメント行以外の行を並列実行する。
# この処理内で、ログは取得していない。ログは$multiple_file_path内のコマンド独自に
# 取得する必要がある。
###############################################################################
$ErrorActionPreference = "Stop"
. .\invoke-process.ps1
###############################################################################
trap {
  $msg = "trap:" + $Error[0]
  $msg
	break
}
###############################################################################
Set-PSDebug -strict

try {
  $multiple_file_path
  $results = @()
  $ids = @()
  get-content $multiple_file_path -encoding Default |
    ForEach-Object {
      if ($_ -match "^#") { return }              # 先頭に#のある行
      if ($_ -match '^[[:space:]]*$') { return }  # 空行
      $fields = -split $_
      $arg = ""
      for ($i = 1; $i -lt $fields.length; $i++) {
        if ($fields[$i] -ne $null) {
          $args += $fields[$i]  # $args配列に追加
        }
      }
      # プロセスの開始
      if ($args -ne $null) {
        $results += Start-Process -FilePath $fields[0] -ArgumentList $args -PassThru
      } else {
        $results += Start-Process -FilePath $fields[0] -PassThru
      }
    }
  # $results配列をすべて処理して、wait(該当のPIDがない場合は無視)
  for($i = 0; $i -lt $results.length; $i++) {
    try {
      wait-process $results[$i].id
      [String]::Format('id:{0}:{1}', $results[$i].id, $results[$i].exitcode)
    } catch [Exception] {
      if ($error[0].CategoryInfo.Category.toString() -ne "ObjectNotFound" -or
          $error[0].CategoryInfo.Activity.toString() -ne "Wait-Process") {
        throw $error[0]
      }
    }
  }
} catch [Exception] {
  $error[0]
  exit 9
}
exit 0
