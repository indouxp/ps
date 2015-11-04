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

    $mutex_name = [String]::Format('Global\{0}', $script.name)            # �V�X�e���S��
    # System.Threading.Mutex https://msdn.microsoft.com/ja-jp/library/system.threading.mutex(v=vs.110).aspx
    $mutexObject = New-Object System.Threading.Mutex($false, $mutex_name) # mutex�쐬
    $timeout = 60*10
    $count = 0
    while ($count -lt $timeout) {
      # WaitOne https://msdn.microsoft.com/ja-jp/library/kzy257t0(v=vs.110).aspx
      # 1:�ҋ@����~���b���B
      # 2:�ҋ@����O�ɃR���e�L�X�g�̓����h���C�����I���� (�������ꂽ�R���e�L�X�g���ɂ���ꍇ)�A
      #   ��ōĎ擾����ꍇ�́Atrue�B����ȊO�̏ꍇ�� false�B
      if ($mutexObject.WaitOne(0, $false)) {  
        break
      } 
      Start-Sleep 1
      $count += 1
    }
    if ($count -eq $timeout) {
      throw "TIMEOUT"
    }
    # ����
    "START"                                                       | write-log
    $log_path                                                     | write-log
    $mutex_name                                                   | write-log
    [String]::Format('wait {0}sec', $count)                       | write-log

    "END"                                                         | write-log
  } catch [Exception] {
    $error[0]                                                     | write-log
    "ABEND"                                                       | write-log
    exit 9
  } finally {
    $mutexObject.ReleaseMutex() # mutex���
    $mutexObject.Close()        # mutex���\�[�X���
    "DONE"                                                        | write-log
  }
}
main
exit 0


