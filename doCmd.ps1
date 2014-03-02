###############################################################################
# %comspec% /c �̈����Ƃ��āA�R�}���h���C���I�v�V��������^����ꂽ�R�}���h�����s
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

  #�R�}���h�����s���W���o�͂̓��e���擾����
  $Process = [System.Diagnostics.Process]::Start($ProcessStartInfo);
  $output = $Process.StandardOutput.ReadToEnd();
  $Process.WaitForExit();

  #���s��SPLIT���ĕԋp����
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
    # �G���[����
    $Error
    exit 1
  } finally {
    $output
    [String]$t.Minutes + "��" + [String]$t.Seconds + "�b" + [String]$t.Milliseconds
    "DONE"
  }
  exit 0
}
###############################################################################
Set-PSDebug -strict
main($args[0])
