
$interface = "10"
$bytes = 32

function run_and_check {
	Param($cmd, $opt, $match_string)

	$proc_start_info = New-Object System.Diagnostics.ProcessStartInfo
	$proc_start_info.FileName = $cmd
	$proc_start_info.Arguments = $opt
	$proc_start_info.RedirectStandardError = $true
	$proc_start_info.RedirectStandardOutput = $true
	$proc_start_info.UseShellExecute = $false

	$proc = New-Object System.Diagnostics.Process
	$proc.StartInfo = $proc_start_info
	$proc.Start() | Out-Null
	$out = ""
	$err = ""
	while ($true) {
		$out += $proc.StandardOutput.ReadtoEnd()
		$err += $proc.StandardError.ReadtoEnd()
		if ($proc.HasExited) {
			break
		}
		Start-Sleep -m 100
	}
	$rc = $proc.ExitCode
	if ($rc -ne 0) {
		$proc.Close()
	  throw ([String]::Format('{0} {1} status {2}.', $cmd, $opt, $rc))
	}
	$result = $out | Select-String -Pattern $match_string -Encoding Default
	if ($result -eq $null) {
		$proc.Close()
	  throw ([String]::Format('{0} {1} output unmatch {2}.', $cmd, $opt, $match_string))
	} else {
		"OK"
		[String]::Format('DEBUG:[{0}]は、[{1}]にマッチ', $out, $match_string)
	}
	$proc.Close()
}

$packet = 2
$opt =  [String]::Format("-n {0} -l 32 192.168.11.1", $packet)
$match_string = [String]::Format("パケット数: 送信 = {0}、受信 = {0}、損失 = 0 \(0% の損失\)", $packet)
run_and_check "ping" $opt $match_string
exit 0
