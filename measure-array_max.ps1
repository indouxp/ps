$str = $null
for ($i = 0; $i -lt 1024; $i++) {
  $str += "�e�X�g�f�[�^"
}
"------------"
[String]::Format('�z��ɑ�����镶����̕�����:{0},�o�C�g��:{1}', $str.length,
                  [System.Text.Encoding]::GetEncoding("Shift_Jis").GetByteCount($str))
"------------"

function run {
  $arr = @()  # �z�񏉊���
  $j = 0      # �J�E���^�[
  $k = 0      # �u���C�N
  $watch = New-Object System.Diagnostics.StopWatch
  $watch.Start()
  while ($true) {
    $arr += $str      # �z��ɒǉ�
    if ($k -eq 1023) {
      $k = 0
      $t = $watch.ElapsedMilliseconds
      [String]::Format('�z��̌�:{0} -- {1}�~���b', $arr.count, $t)
    }
    $j += 1
    $k += 1
  }
}

try {
  run
} catch [Exception] {
  $error[0]
  exit 9
}
exit 0
