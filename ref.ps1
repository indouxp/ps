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
    $ref_names.Value += $value.Name
  }
}

Set-PSDebug -strict
main
