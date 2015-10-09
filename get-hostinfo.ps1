###############################################################################
# ホスト情報の取得
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
  # ディスク
  [System.Console]::Write([String]::Format(    'DISK    :'))
  Get-WmiObject -Class Win32_DiskDrive
  # ドメイン
  $domain = (Get-WMIObject Win32_ComputerSystem).PartOfDomain
  [System.Console]::WriteLine([String]::Format('DOMAIN  :{0}', $domain))
  Get-WmiObject Win32_ComputerSystem
  # ネットワーク
  [System.Console]::Write([String]::Format('NETWORK :'))
  Get-WmiObject Win32_NetworkAdapterConfiguration
  ipconfig /all
  # 役割情報、機能情報
  try {
    Import-Module ServerManager
    Get-WindowsFeature
  } catch [Exception] {
    $Error[0].ToString()
  }
  # 適用済みセキュリティパッチ
  Get-WMIObject Win32_QuickFixEngineering

} catch [Exception] {
  $Error[0]
  exit 9
}
exit 8
