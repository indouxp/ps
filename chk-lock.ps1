$ErrorActionPreference = "Stop"
set-variable -name script -value (get-item $MyInvocation.MyCommand.path) -option constant

function main {
  try {
    [String]::Format('{0}:LastWriteTime:{1}', $script.name, $script.lastwritetime)
    get-childitem "c:\users\indou\documents\log\lock.ps1*log" |
      foreach-object {
        $msg = $null
        $start = $null
        $done = $null
        $start = select-string ":START" $_
        $fields = $start -split ":"
        [String]::Format('{0} {1} {2}', $fields[3], $fields[4], $fields[6])
        $done = select-string ":remove-lock" $_
        $fields = $done -split ":"
        [String]::Format('{0} {1} {2}', $fields[3], $fields[4], $fields[6])

        if ($_ -match "ABEND") {  # ABENDがある場合
          $msg += [String]::Format(' "exist ABEND"')
        }
        if ($start -eq $null) {   # STARTがない場合
          $msg += [String]::Format(' "no START"')
        }
        if ($done -eq $null) {    # remove-lockされていない場合
          $msg += [String]::Format(' "no remove-lock"')
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
        if ($fields[2] -eq "remove-lock") {
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

#20151103.162954.604:8168:lock.ps1:START
#20151103.162954.699:8168:lock.ps1:remove-lock $lock.ps1.lock.d
