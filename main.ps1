
$script:basename = $MyInvocation.MyCommand.Name
. (join-path (split-path $MyInvocation.MyCommand.Path -parent) "sub0.ps1")

try {
  "�J�n" | write-log
  start-sleep 1
  "�I��" | write-log
} catch [exception] {
  "�ُ�I��" | write-log
} finally {
  "�Ō�" | write-log
}
