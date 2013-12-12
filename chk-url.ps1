
$url = "http://192.168.0.244/"
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

