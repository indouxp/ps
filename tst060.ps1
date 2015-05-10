###############################################################################
#
# route add
#
###############################################################################
Param($ip)

$interface = 10
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
	"START"
	$out = ""
	$err = ""
	while ($true) {
		$proc.ProcessName
		$proc.ExitCode
		$out += $proc.StandardOutput.ReadtoEnd()
		$err += $proc.StandardError.ReadtoEnd()
		if ($proc.HasExited) {
			break
		}
		Start-Sleep -s 1
	}
	"END"
	$rc = $proc.ExitCode
	if ($rc -ne 0) {
		$proc.Close()
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

	#$out = $proc.StandardOutput.ReadtoEnd()
	#$err = $proc.StandardError.ReadtoEnd()
	$out
	$out.length

	$pattern = $match_string
	$result = $out | Select-String -Pattern $pattern
	if ($result -ne $null) {
		"OK"
	} else {
		"NG"
	}
	$proc.Close()
}
Set-PSDebug -strict
$opt =  [String]::Format("add 192.168.11.0 mask 255.255.255.0 {0} if {1}",  $ip, $interface)
$match_string = "OK\!"
main "route" $opt $match_string

$opt = "print"
$match_string = [String]::Format("192.168.11.0\s+255.255.255.0\s+192.168.0.2")
main "route" $opt $match_string

$opt =  [String]::Format("delete 192.168.11.0 mask 255.255.255.0")
$match_string = "OK\!"
main "route" $opt $match_string

exit 0
