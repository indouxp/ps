###############################################################################
# �֐��ւ̎Q�Ɠn���ł̌Ăяo���T���v��
###############################################################################
function main {
  $names = @()
  $files = get-childitem

  # �p�����[�^�����w�肵�Ȃ�
  func ([ref]$files) ([ref]$names) 
  # �p�����[�^�����w�肷��B
  func -ref_files ([ref]$files) -ref_names ([ref]$names)

  foreach ($name in $names) {
    $name
  }
}

function func {
  Param (
    [ref]$ref_files,
    [ref]$ref_names
  )
  foreach ($value in $ref_files.Value) {
    # $names�̔z��ւ̎Q�ƂɃt�@�C�����݂̂�����
    $ref_names.Value += $value.Name
  }
}

Set-PSDebug -strict # �l���ݒ肳���O�ɕϐ����Q�Ƃ��ꂽ�ꍇ�ɁA�C���^�[�v���^�[����O���X���[����悤�Ɏw�肵�܂��B
main
