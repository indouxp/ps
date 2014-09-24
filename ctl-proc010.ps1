
$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "sleep.exe" # ~\utils��sleep.exe(bcc32�ɂ��)
$pinfo.RedirectStandardError = $true
$pinfo.RedirectStandardOutput = $true
$pinfo.UseShellExecute = $false
$pinfo.Arguments = "2"

$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo
$p.Start() | Out-Null

$p.WaitForExit()
$p.ExitCode
$p.StartTime
$p.ExitTime
$p.Cpu
$p | get-member | out-string > member.txt
