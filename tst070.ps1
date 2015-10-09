###############################################################################
#
# �A�z�z��ւ̒ǉ��p�t�H�[�}���X�̑���
# �A�z�z��ɒǉ�����max������Amax/10���폜������A�S���o�͂̎���
# �A�z�z��ɒǉ�����max������Amax/10���폜�̈�(0)��t������A�S���ǂ݁A��ȊO���o�͂��鎞��
#
###############################################################################
Set-PSDebug -strict
$ErrorActionPreference = "Stop"

try {
  $max = 100000
  $h1 = @{}
  [String]::Format(" �n�b�V����{0}���f�[�^�̒ǉ�", $max)
  $result = measure-command {
    1 .. $max |
      foreach-object {
        $h1[$(get-random $_).toString()] =  $_
      }
  }
  $result.TotalSeconds

  [String]::Format(" �n�b�V����{0}���f�[�^�̍폜(remove)", ($max/10))
  $result = measure-command {
    $count = 0
    1 .. ($max/10) |
      foreach-object {
        $h1.remove($(get-random $_).toString())
        $count += 1
      }
    [String]::Format('remove:{0}', $count) | write-host
  }
  $result.TotalSeconds

  [String]::Format(" �n�b�V���S������")
  $result = measure-command {
    $count = 0
    foreach($key in $h1.keys) {
      $count += 1
    }
    [String]::Format('count:{0}', $count) | write-host
  }
  $result.TotalSeconds

  $h2 = @{}
  [String]::Format(" �n�b�V����{0}���f�[�^�̒ǉ�", $max)
  $result = measure-command {
    1 .. $max |
      foreach-object {
        $h2[$(get-random $_).toString()] =  $_
      }
  }
  $result.TotalSeconds

  [String]::Format(" �n�b�V����{0}���f�[�^�̍폜(0)", ($max/10))
  $result = measure-command {
    $count = 0
    1 .. ($max/10) |
      foreach-object {
        $h2[$(get-random $_).toString()] = 0
        $count += 1
      }
    [String]::Format('remove:{0}', $count) | write-host
  }
  $result.TotalSeconds

  [String]::Format(" �n�b�V���S������(0�ȊO)")
  $result = measure-command {
    $count = 0
    foreach($key in $h2.keys) {
      if ($key -ne 0) {
        $count += 1
      }
    }
    [String]::Format('count:{0}', $count) | write-host
  }
  $result.TotalSeconds

} catch [Exception] {
  $error[0]
  exit 1
}
exit 0
