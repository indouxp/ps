# �J�����g�t�H���_�̈�K�w����results�t�H���_�̊g���q�Ȃ��̃t�@�C���𔲂��o����copy����B
$dirs = get-childitem 
foreach ($dir in $dirs) {
  if ($dir.Attributes -eq "Directory") {
    $prefix = "UnixBench." + $dir.Name.Replace(".UnixBench", "")
    $results_dir = $dir.FullName + '\' + 'results'
    $files = get-childitem $results_dir
    foreach ($file in $files) {
      $ymd_suffix = $file -replace ".+-(\d{4}-\d{2}-\d{2}-\d{2}.*)", '$1'
      $ymd = $ymd_suffix -replace "(\d{4}-\d{2}-\d{2})-\d{2}.*", '$1'
      $suffix = $ymd_suffix -replace ".*(\..+)", '$1'
      if ($suffix -eq $ymd_suffix) { # ��L��replace�Ɏ��s�����ꍇ
        $name = $prefix + "." + $ymd + ".txt"
      } else {
        $name = $prefix + "." + $ymd + $suffix
      }
      $file.FullName, $name
      copy-item $file.FullName $name
    }
  }
}

