              
$command = "sleep.exe"
$option = "5"
$stdoutPath = ".\stdout.txt"
$stderrPath = ".\stderr.txt"

$process = Start-Process                    `
                      -FilePath $command    `
                      -ArgumentList $option `
                      -PassThru             `
                      -RedirectStandardOutput $stdoutPath `
                      -RedirectStandardError $stderrPath  `
                      -NoNewWindow
$process.id
#$process.WaitForExit()
$id = $process.id
"wait $id"
Wait-Process -Id $id
$msg = "StartTime:" + $process.StartTime
$msg
$msg = "ExitTime:" + $process.ExitTime
$msg
$msg = "ExitCode:" + $process.ExitCode
$msg
