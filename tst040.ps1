# ‚¤‚Ü‚­‚¢‚©‚È‚¢
function main {
	$result = Start-process -FilePath "ping.exe" -ArgumentList "192.168.0.2" -PassThru -Wait
	if ($result.StandardError -eq $null) {
		"NULL"
	}
	$result = Start-process -FilePath "ping.exe" -ArgumentList "192.168.0.3" -PassThru -Wait
	if ($result.StandardError -eq $null) {
		"NULL"
	}
}
Set-PSDebug -strict
main
