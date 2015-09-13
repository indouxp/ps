$script_path = $MyInvocation.MyCommand.Path
$sleep_time = (@(1..3) | get-random)
$now = get-date -Format "yyyyMMdd.HHmmss.ffff"
$rc = (@(0..1) | get-random)
$log = [String]::Format('{0}.{1}.{2}.log', $script_path, $now, $PID)

Start-Sleep $sleep_time
[String]::Format('{0} pid:{1} time:{2} rc:{3}', $script_path, $PID, $sleep_time, $rc) | out-file -Encoding Default $log
exit $rc
