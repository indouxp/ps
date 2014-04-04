# �t�@�C�����u��
#$targets = get-childitem "���oLinux[0-9][0-9][0-9][0-9][0-9][0-9].pdf"
#$targets = get-childitem "���o�\�t�g�E�F�A[0-9][0-9][0-9][0-9][0-9][0-9].pdf"
#$targets = get-childitem "LinuxWorld[0-9][0-9][0-9][0-9][0-9][0-9].pdf"
$targets = get-childitem "SoftwareDesign[0-9][0-9][0-9][0-9][0-9][0-9].pdf"

$count = 0
foreach ($file in $targets) {
  $NewName = $file.Name -replace "SoftwareDesign", "SoftwareDesign."
  rename-item -path $file -newname $NewName
  $count += 1
}
$count
