$watch = New-Object System.Diagnostics.StopWatch
$watch.Start()
Start-Sleep 2
$watch.Stop()
$t = $watch.Elapsed
"{0} •b" -f $t.Seconds
[String]::Format('{0}•b', $t.Seconds)
