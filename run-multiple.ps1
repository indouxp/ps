Param($multiple_file_path)
###############################################################################
# $multiple_file_path��ǂݍ��݁A�R�����g�s�ȊO�̍s�������s����B
# ���̏������ŁA���O�͎擾���Ă��Ȃ��B���O��$multiple_file_path���̃R�}���h�Ǝ���
# �擾����K�v������B
###############################################################################
$ErrorActionPreference = "Stop"
. .\invoke-process.ps1
###############################################################################
trap {
  $msg = "trap:" + $Error[0]
  $msg
	break
}
###############################################################################
Set-PSDebug -strict

try {
  $multiple_file_path
  $results = @()
  $ids = @()
  get-content $multiple_file_path -encoding Default |
    ForEach-Object {
      if ($_ -match "^#") { return }              # �擪��#�̂���s
      if ($_ -match '^[[:space:]]*$') { return }  # ��s
      $fields = -split $_
      $arg = ""
      for ($i = 1; $i -lt $fields.length; $i++) {
        if ($fields[$i] -ne $null) {
          $args += $fields[$i]  # $args�z��ɒǉ�
        }
      }
      # �v���Z�X�̊J�n
      if ($args -ne $null) {
        $results += Start-Process -FilePath $fields[0] -ArgumentList $args -PassThru
      } else {
        $results += Start-Process -FilePath $fields[0] -PassThru
      }
    }
  # $results�z������ׂď������āAwait(�Y����PID���Ȃ��ꍇ�͖���)
  for($i = 0; $i -lt $results.length; $i++) {
    try {
      wait-process $results[$i].id
      [String]::Format('id:{0}:{1}', $results[$i].id, $results[$i].exitcode)
    } catch [Exception] {
      if ($error[0].CategoryInfo.Category.toString() -ne "ObjectNotFound" -or
          $error[0].CategoryInfo.Activity.toString() -ne "Wait-Process") {
        throw $error[0]
      }
    }
  }
} catch [Exception] {
  $error[0]
  exit 9
}
exit 0
