$erroractionpreference = "Stop"
set-variable -name script -value $Myinvocation.mycommand -option constant
set-variable -name now -value (get-date -format "yyyyMMdd.HHmmss.fff") -option constant
set-variable -name timeout -value (60) -option constant

$log_dir  = "C:\Users\indou\Documents\log"
$log_name = [String]::Format('{0}.{1}.{2}.log', $script.name, $now, $pid)
$log_path = join-path $log_dir $log_name

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
function main {
  try {

    $mutex_name = [String]::Format('Global\{0}', $script.name)            # グローバルな名前
    $mutexObject = New-Object System.Threading.Mutex($false, $mutex_name) # mutex作成
    while ($true) {
      if ($mutexObject.WaitOne(0, $false)) {
        break
      } 
      Start-Sleep 1
    }
    # 処理
    "START"                                                       | write-log
    $log_path                                                     | write-log
    $mutex_name                                                   | write-log


    "END"                                                         | write-log
    $mutexObject.ReleaseMutex() # mutex解放
    $mutexObject.Close()        # mutexリソース解放
  } catch [Exception] {
    $error[0]                                                     | write-log
    "ABEND"                                                       | write-log
    exit 9
  }
}
main
exit 0


