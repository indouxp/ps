#
# http�Ő����Ď�
#
# �F�؂�����ꍇ�́A���܂������Ȃ��B
# PS C:\Users\indou\Documents\GitHub\ps> .\chk-url.ps1
# �����[�g �T�[�o�[���G���[��Ԃ��܂���: (401) ������Ă��܂���
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

