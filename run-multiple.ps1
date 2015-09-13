Param($multiple_file_path)
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
      if ($_ -match "^#") { return }
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
      $ids += $results.id # �v���Z�XID���A$ids�z��ɒǉ�
    }
  # $ids�z������ׂď������āAwait(�Y����PID���Ȃ��ꍇ�͖���)
  $value =0
  foreach ($id in $ids) {
    try {
      wait-process $id
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
