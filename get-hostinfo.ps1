###############################################################################
# �z�X�g���̎擾
###############################################################################

Set-PSDebug -strict
$ErrorActionPreference = "Stop"
trap {
  $Error[0]
  exit 8
}

try {
  $OSVersion = [Environment]::OSVersion
  [System.Console]::WriteLine([String]::Format('HOSTNAME:{0}', (hostname)))
  [System.Console]::WriteLine([String]::Format('OS      :{0}', $OSVersion))
  # �f�B�X�N
  [System.Console]::Write([String]::Format(    'DISK    :'))
  Get-WmiObject -Class Win32_DiskDrive
  # �h���C��
  $domain = (Get-WMIObject Win32_ComputerSystem).PartOfDomain
  [System.Console]::WriteLine([String]::Format('DOMAIN  :{0}', $domain))
  Get-WmiObject Win32_ComputerSystem
  # �l�b�g���[�N
  [System.Console]::Write([String]::Format('NETWORK :'))
  Get-WmiObject Win32_NetworkAdapterConfiguration
  ipconfig /all
  # �������A�@�\���
  try {
    Import-Module ServerManager
    Get-WindowsFeature
  } catch [Exception] {
    $Error[0].ToString()
  }
  # �K�p�ς݃Z�L�����e�B�p�b�`
  Get-WMIObject Win32_QuickFixEngineering

} catch [Exception] {
  $Error[0]
  exit 9
}
exit 8
