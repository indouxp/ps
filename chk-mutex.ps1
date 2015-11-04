$ErrorActionPreference = "Stop"
set-variable -name script -value (get-item $MyInvocation.MyCommand.path) -option constant

function main {
  try {
    [String]::Format('{0}:LastWriteTime:{1}', $script.name, $script.lastwritetime)
    get-childitem "c:\users\indou\documents\log\mutex.ps1*log" |
      foreach-object {
        $msg = $null
        $start = $null
        $end = $null
        $start = select-string ":START" $_
        $fields = $start -split ":"
        [String]::Format('{0} {1} {2}', $fields[3], $fields[4], $fields[6])
        $end = select-string ":END" $_
        $fields = $end -split ":"
        [String]::Format('{0} {1} {2}', $fields[3], $fields[4], $fields[6])
        $done = select-string ":DONE" $_

        if ($_ -match "ABEND") {  # ABENDがある場合
          $msg += [String]::Format(' "exist ABEND"')
        }
        if ($start -eq $null) {   # STARTがない場合
          $msg += [String]::Format(' "no START"')
        }
        if ($done -eq $null) {    # DONEがない場合
          $msg += [String]::Format(' "no DONE"')
        }
        if ($msg -ne $null) {
          $msg
          get-content -encoding string $_
        }
      
      }                                                       |
      sort-object                                             |
      foreach-object {
        $msg = $null
        $_
        $fields = $_ -split " "
        if ($fields[2] -eq "END") {
          if ($prev_fields[1] -ne $fields[1]) {
            $msg += " 前の行とPIDが異なる"
          }
          if ($prev_fields[2] -ne "START") {
            $msg += " 前の行がSTARTでない"
          }
        }
        if ($msg -ne $null) {
          $msg
        }
        $prev_fields = $fields
      }

  } catch [Exception] {
    $error[0]
    exit 9
  }
}

Set-PSDebug -strict
main | tee ($script.name + ".log")
exit 0
