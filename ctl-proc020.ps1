
$commands = @(
  @{
    command = "sleep.exe";
    arguments = "3";
  },
  @{
    command = "busy.exe";
    arguments = "90000";
  }
  @{
    command = "busy.exe";
    arguments = "40000";
  }
)

$pinfo = @()
$proc = @()

for ($i = 0; $i -lt $commands.length; $i++) {
  $pinfo += New-Object System.Diagnostics.ProcessStartInfo
  $pinfo[$i].FileName = $commands[$i].command
  $pinfo[$i].Arguments = $commands[$i].arguments
  $pinfo[$i].RedirectStandardError = $true
  $pinfo[$i].RedirectStandardOutput = $true
  $pinfo[$i].UseShellExecute = $false
  $proc += New-Object System.Diagnostics.Process
  $proc[$i].StartInfo = $pinfo[$i]
  $proc[$i].Start() | Out-Null
}

for ($i = 0; $i -lt $commands.length; $i++) {
  ("wait " + $commands[$i].command + " " + $commands[$i].arguments)
  $proc[$i].WaitForExit()
  $msg = $commands[$i].command + " " + $commands[$i].arguments
  $msg += " done. "
  $msg += ($proc[$i].StartTime.toString("yyyy/MM/dd HH:mm:ss"))
  $msg += "-"
  $msg += ($proc[$i].ExitTime.toString("yyyy/MM/dd HH:mm:ss"))
  $msg += (" status was " + $proc[$i].ExitCode)
  $msg
  $out = $proc[$i].StandardOutput.ReadtoEnd()
  $out
  $err = $proc[$i].StandardError.ReadtoEnd()
  $err
}
