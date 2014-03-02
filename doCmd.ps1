###############################################################################
# %comspec% /c の引数として、コマンドラインオプションから与えられたコマンドを実行
#
#
###############################################################################
function ExecCmd([string]$strCmd)
{
  $Process = [System.Diagnostics.Process];
  $ProcessStartInfo = [System.Diagnostics.ProcessStartInfo];
  $output = [string];

  $ProcessStartInfo = New-Object System.Diagnostics.ProcessStartInfo;

  $ProcessStartInfo.FileName = [System.Environment]::GetEnvironmentVariable("ComSpec");
  $ProcessStartInfo.Arguments = "/c " + $strCmd;
  $ProcessStartInfo.Arguments
  $ProcessStartInfo.UseShellExecute = $false;
  $ProcessStartInfo.RedirectStandardOutput = $true;

  #コマンドを実行し標準出力の内容を取得する
  $Process = [System.Diagnostics.Process]::Start($ProcessStartInfo);
  $output = $Process.StandardOutput.ReadToEnd();
  $Process.WaitForExit();

  #改行でSPLITして返却する
  return $output.split("`n");
}
###############################################################################
function main([string]$cmd) {
  try {
    "START"
    $watch = New-Object System.Diagnostics.StopWatch
    $watch.Start()
    $output = ExecCmd($cmd)
    $watch.Stop()
    $t = $watch.Elapsed
  } catch [Exception] {
    # エラー処理
    $Error
    exit 1
  } finally {
    $output
    [String]$t.Minutes + "分" + [String]$t.Seconds + "秒" + [String]$t.Milliseconds
    "DONE"
  }
  exit 0
}
###############################################################################
Set-PSDebug -strict
main($args[0])
