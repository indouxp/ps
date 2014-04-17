#
# httpで生死監視
#
# 認証がある場合は、うまくいかない。
# PS C:\Users\indou\Documents\GitHub\ps> .\chk-url.ps1
# リモート サーバーがエラーを返しました: (401) 許可されていません
# PS C:\Users\indou\Documents\GitHub\ps> 

$url = "http://192.168.0.244/"
$url = "http://192.168.0.1/"
$response = $Null
try {
  [System.Net.HttpWebRequest]$request = [System.Net.WebRequest]::Create($url)
  $response = $request.GetResponse()
  write ("{0}:`t{1}" -f [int]$response.StatusCode, $response.StatusCode)
  $response.Close()
  exit(0)
} catch [Exception]{
  Write-Host $_
  exit(1)
} finally {
  if ($response -ne $Null) {
    $response.Close()
  }
}

