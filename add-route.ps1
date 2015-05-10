###############################################################################
#
#
#
###############################################################################
$interface = "10"
$bytes = 32

function run_and_check {
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
	$pattern = $match_string
	$result = $out | Select-String -Pattern $pattern
	if ($result -eq $null) {
		$proc.Close()
	  throw ([String]::Format('{0} {1} output unmatch {2}.', $cmd, $opt, $pattern))
	}
	$proc.Close()
}

function search_and_route {
  Param($array_of_ip)

  $proc_info = @()
  $proc = @()
	# ping 並列実行設定
	for ($i = 0; $i -lt $array_of_ip.length; $i++) {
		$proc_info += New-Object System.Diagnostics.ProcessStartInfo # 配列に追加
		$proc_info[$i].FileName = "ping"
		$proc_info[$i].Arguments = [String]::Format('-l {0} -n 1 {1}', $bytes, $array_of_ip[$i])
		$proc_info[$i].RedirectStandardError = $true
		$proc_info[$i].RedirectStandardOutput = $true
		$proc_info[$i].UseShellExecute = $false

		# ping開始
		$proc += New-Object System.Diagnostics.Process	# 配列に追加
		$proc[$i].StartInfo = $proc_info[$i]
		$proc[$i].Start() | Out-Null										# ping開始
	}
	# 結果待ち
	for ($i = 0; $i -lt $array_of_ip.length; $i++) {
		#[String]::Format('wait {0}', $array_of_ip[$i])
		$out = ""
		$err = ""
		while ($true) {
			$out += $proc[$i].StandardOutput.ReadtoEnd()
			$err += $proc[$i].StandardError.ReadtoEnd()
			if ($proc.HasExited) {
				break
			}
			Start-Sleep -m 100
		}
		$msg = $array_of_ip[$i]
		$msg += " done. "
		$msg += ($proc[$i].StartTime.toString("yyyy/MM/dd HH:mm:ss"))
		$msg += "-"
		$msg += ($proc[$i].ExitTime.toString("yyyy/MM/dd HH:mm:ss"))
		$msg += (" status was " + $proc[$i].ExitCode)
		$msg

		$pattern = [String]::Format("{0} からの応答: バイト数 ={1}", $array_of_ip[$i], $bytes)
		$result = $out | Select-String -Pattern $pattern
		if ($result -ne $null) {
			route_add $array_of_ip[$i]
			$result = ping_wzr_hp_g450h_lan_side "192.168.11.1"
			if ($result -eq 0) {
				[String]::Format("ping {0} OK.", "192.168.11.1")
				break
			}
			route_delete
		}
	}
}

function ping_wzr_hp_g450h_lan_side {
  Param($ip)
	$opt = [String]::Format('-l {0} -n 1 {1}', $bytes, $ip)
	$match_string = [String]::Format("{0} からの応答: バイト数 ={1}", $ip, $bytes)
	run_and_check "ping" $opt $match_string
	return 0
}

function route_add {
  Param($ip)
	$opt =  [String]::Format("add 192.168.11.0 mask 255.255.255.0 {0} if {1}",  $ip, $interface)
	$match_string = "OK\!"
	run_and_check "route" $opt $match_string

	$opt = "print"
	$match_string = [String]::Format("192.168.11.0\s+255.255.255.0\s+192.168.0.2")
	run_and_check "route" $opt $match_string
}

function route_delete {
	$opt =  [String]::Format("delete 192.168.11.0 mask 255.255.255.0")
	$match_string = "OK\!"
	run_and_check "route" $opt $match_string
}

function main {
	try {
		$addresses = 
			@("192.168.0.2","192.168.0.3","192.168.0.4","192.168.0.5","192.168.0.6")
		search_and_route $addresses
  } catch [Exception] {
    $error[0]
    exit 1
  } finally {
  }
  exit 0
}
Set-PSDebug -strict
main
