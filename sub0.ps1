
function write-log {
  param(
    [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
    [String]$msg
  )
  #$now = get-date -uFormat "%Y/%m/%d %H:%M:%S"
  $now = get-date -Format "yyyy/MM/dd HH:mm:ss.fff"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File ($basename + "." +  "log") -encoding Default -append -ErrorAction Stop
}
