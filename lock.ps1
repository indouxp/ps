$erroractionpreference = "Stop"
set-variable -name script -value $Myinvocation.mycommand -option constant
set-variable -name now -value (get-date -format "yyyyMMdd.HHmmss.fff") -option constant
set-variable -name timeout -value (60) -option constant

$is_lock = $false
$lock_dir  = "C:\Users\indou\Documents\lock.d"
$lock_name = [String]::Format('{0}.lock.d', $script.name)
$lock_path = join-path $lock_dir $lock_name

$log_dir  = "C:\Users\indou\Documents\log"
$log_name = [String]::Format('{0}.{1}.{2}.log', $script.name, $now, $pid)
$log_path = join-path $log_dir $log_name

###############################################################################
function remove-lock($lock_name) {
  if ($is_lock -eq $true) {
    remove-item (join-path "C:\Users\indou\Documents\lock.d" $lock_name)
    [String]::Format('remove-lock {0}', $lock_name) | write-log
  }
}
###############################################################################
function write-log {
  param([parameter(valuefrompipeline=$true)] $msg)
  [String]::Format('{0}:{1}:{2}:{3}',
    (get-date -format "yyyyMMdd.HHmmss.fff"),
    $pid,
    $script.name,
    $msg) | out-file $log_path -encoding default -append
}

###############################################################################
function wait-run {
  Param($lock_path)
  [String]::Format('wait-run') | write-log
  $count = 0
  while ($count -lt $timeout) {
    try {
      new-item -itemtype Directory $lock_path | out-null
      break
    } catch [Exception] {
      $error[0]
      Start-Sleep 1
      $count += 1
      if (($count % 60) -eq 0) {
        [String]::Format('wait {0,4}sec') | write-log
      }
    }
  }
  if ($count -eq $timeout) {
    return $false
  }
  [String]::Format('wait {0,4}sec', $count) | write-log
  return $true
}

###############################################################################
function main {
  try {
    "START"                 | write-log
    $log_path               | write-log
    $lock_path              | write-log
    $is_lock = wait-run $lock_path
    "END"                   | write-log
    remove-lock($lock_name)
  } catch [Exception] {
    $error[0]               | write-log
    "ABEND"                 | write-log
    remove-lock($lock_name)
    exit 9
  }
}
main
exit 0


