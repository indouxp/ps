$str = $null
for ($i = 0; $i -lt 1024; $i++) {
  $str += "�e�X�g�f�[�^"
}
"------------"
[String]::Format('�n�b�V���ɑ�����镶����̕�����:{0},�o�C�g��:{1}', $str.length,
                  [System.Text.Encoding]::GetEncoding("Shift_Jis").GetByteCount($str))
"------------"

function run {
  $hash = @{} # �n�b�V���̏�����
  $j = 0      # �J�E���^�[
  $k = 0      # �u���C�N�J�E���^�[
  $watch = New-Object System.Diagnostics.StopWatch
  $watch.Start()
  while ($true) {
    $key = [String]::Format('key{0,00000}', $j) # 8byte�̃L�[
    $hash.add($key, $str)                       # �n�b�V���ւ̒ǉ�
    if ($k -eq 1023) {
      $count = 0
      $total = 0
      foreach ($key in $hash.keys) {
        $count += 1
        $total += $hash[$key].length
      }
      $t = $watch.ElapsedMilliseconds
      [String]::Format('�n�b�V���̌�:{0}, ������:{1} -- {2}�~���b', $count, $total, $t)
      $k = 0
    }
    $j += 1 # �J�E���^�[
    $k += 1 # �u���C�N�J�E���^�[
  }
}

try {
  run
} catch [Exception] {
  $error[0]
  exit 9
}
exit 0
