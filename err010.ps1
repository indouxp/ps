param([int]$num = 0)
# �Ǘ��Ҍ����Ŏ��s���Ȃ��Ƃ���
# ��O�������̏������`
trap [Exception] {
  # �C�x���g�E���O�ɏ�������
  [Diagnostics.EventLog]::WriteEntry("PowerShell Script", $error[0].exception, "Error", 1)
  exit 9
}

# ����$num�ŏ��Z�����l��\���i����$num��0�̏ꍇ�͗�O�����j
10 / $num
"�������I�����܂����B"
exit 0
