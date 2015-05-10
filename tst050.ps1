###############################################################################
#
# 引数のIP Addressにping。標準出力の成功出力を判断
#
###############################################################################
Param($ip)

$bytes = 32

function main {
	Param($cmd, $opt, $match_string)

	$proc_info = New-Object System.Diagnostics.ProcessStartInfo
	$proc_info.FileName = $cmd
	$proc_info.Arguments = $opt
	$proc_info.RedirectStandardError = $true
	$proc_info.RedirectStandardOutput = $true
	$proc_info.UseShellExecute = $false

	$proc = New-Object System.Diagnostics.Process
	$proc.StartInfo = $proc_info
	$proc.Start() | Out-Null
	$proc.WaitForExit()
	$rc = $proc.ExitCode
	if ($rc -ne 0) {
		"RC:NG"
	  exit 1
	}
	$msg = $ip
	$msg += " done. "
	$msg += ($proc.StartTime.toString("yyyy/MM/dd HH:mm:ss"))
	$msg += "-"
	$msg += ($proc.ExitTime.toString("yyyy/MM/dd HH:mm:ss"))
	$msg += (" status was " + $proc.ExitCode)
	$msg

	$out = $proc.StandardOutput.ReadtoEnd()
	#$err = $proc.StandardError.ReadtoEnd()

	$pattern = $match_string
	$result = $out | Select-String -Pattern $pattern
	if ($result -ne $null) {
		"OK"
	} else {
		"NG"
	}
}
Set-PSDebug -strict
$opt = [String]::Format('-l {0} -n 1 {1}', $bytes, $ip)
$match_string = [String]::Format("{0} からの応答: バイト数 ={1}", $ip, $bytes)
main "ping" $opt $match_string
exit 0
