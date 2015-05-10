###############################################################################
#
#
#
###############################################################################
$interface = "10"
$bytes = 32

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
		$proc[$i].WaitForExit()
		$msg = $array_of_ip[$i]
		$msg += " done. "
		$msg += ($proc[$i].StartTime.toString("yyyy/MM/dd HH:mm:ss"))
		$msg += "-"
		$msg += ($proc[$i].ExitTime.toString("yyyy/MM/dd HH:mm:ss"))
		$msg += (" status was " + $proc[$i].ExitCode)
		#$msg

		$out = $proc[$i].StandardOutput.ReadtoEnd()
		#$err = $proc[$i].StandardError.ReadtoEnd()

		$pattern = [String]::Format("{0} からの応答: バイト数 ={1}", $array_of_ip[$i], $bytes)
		$result = $out | Select-String -Pattern $pattern
		if ($result -ne $null) {
			route_add $array_of_ip[$i]
			$result = ping_wzr_hp_g450h_lan_side $array_of_ip[$i]
			if ($result -eq 0) {
				break
			}
			route_delete
		}
	}
}

function ping_wzr_hp_g450h_lan_side {
  Param($ip)
	$proc_info = New-Object System.Diagnostics.ProcessStartInfo # 配列に追加
	$proc_info.FileName = "ping"
	$proc_info.Arguments = [String]::Format('-l {0} -n 1 {1}', $bytes, $ip)
	$proc_info.RedirectStandardError = $true
	$proc_info.RedirectStandardOutput = $true
	$proc_info.UseShellExecute = $false
	# ping開始
	$proc = New-Object System.Diagnostics.Process								# 配列に追加
	$proc.StartInfo = $proc_info
	$proc.Start() | Out-Null																		# ping開始
	$proc.WaitForExit()
	$out = $proc.StandardOutput.ReadtoEnd()
	$pattern = [String]::Format("{0} からの応答: バイト数 ={1}", $array_of_ip[$i], $bytes)
	$result = $out | Select-String -Pattern $pattern
	if ($result -ne $null) {
	  "OK"
		return 0
	}
	"NG"
	return 1
}

function route_add {
  Param($ip)
	$arg =  [String]::Format("add {0} mask 255.255.255.0 {1} if {2}", "192.168.11.1", $ip, $interface)
	$result = Start-process -FilePath "route.exe" -ArgumentList $arg -PassThru -Wait
	if ($result.exitcode -ne 0) {
		throw [String]::Format('{0} {1} fail.', "route.exe", $arg)
	}
	$result = Start-process -FilePath "route.exe" -ArgumentList "print" -PassThru -Wait
	if ($result.exitcode -ne 0) {
		throw [String]::Format('{0} {1} fail.', "route.exe", "print")
	}
}

function route_delete {
	$arg =  [String]::Format("delete {0} mask 255.255.255.0", "192.168.11.1")
	$result = Start-process -FilePath "route.exe" -ArgumentList $arg -PassThru -Wait
	if ($result.exitcode -ne 0) {
		throw [String]::Format('{0} {1} fail.', "route.exe", $arg)
	}
	$result = Start-process -FilePath "route.exe" -ArgumentList "print" -PassThru -Wait
	if ($result.exitcode -ne 0) {
		throw [String]::Format('{0} {1} fail.', "route.exe", "print")
	}
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
