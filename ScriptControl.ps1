# http://www.atmarkit.co.jp/fwin2k/win2ktips/992callwsh/callwsh.html
# ScriptControl�I�u�W�F�N�g�Ŏ��s����X�N���v�g���`
$prog = '
  Function ShowMessage(ByVal msg)
    MsgBox(msg)
  End Function
'
# ScriptControl�I�u�W�F�N�g�𐶐�
$ctrl = New-Object -ComObject ScriptControl
# �g�p���錾���ݒ�
$ctrl.Language = 'VBScript'
# �X�N���v�g�E�R�[�h����͂̂����œo�^
$ctrl.AddCode($prog)
# �o�^�����֐����Ăяo�����߂�CodeObject�I�u�W�F�N�g��Ԃ�
$ctrl.CodeObject
