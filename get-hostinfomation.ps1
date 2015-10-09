
function start_header()
{
  Write-Output "===================="
  Write-Output "OS情報"
  $date = Get-Date
  Write-Output "開始時刻:$date"
  Write-Output "===================="
}

function header($title)
{
  Write-Output ""
  Write-Output "--------------------"
  Write-Output $title
  Write-Output "--------------------"
}

start_header

#ホスト名
header "ホスト名"
hostname


#OSバージョン
header "OSバージョン"
[Environment]::OSVersion | fl


#ディスク構成
header "ディスク構成"
Get-WmiObject Win32_DiskDrive


#ドメイン参加情報
header "ドメイン参加情報"
$domain = (Get-WMIObject Win32_ComputerSystem).PartOfDomain
if($domain)
{
  Write-Output "joined to Domain."
} else {
  Write-Output "not joined to Domain(WORKGROUP)."
}
Get-WmiObject Win32_ComputerSystem


#ネットワーク設定
header "ネットワーク設定"
#Get-WmiObject Win32NetworkAdapterConfiguration
ipconfig /all


#役割情報、機能情報
header "役割情報、機能情報"
Import-Module ServerManager
Get-WindowsFeature


#適用済みセキュリティパッチ
header "適用済みセキュリティパッチ"
Get-WmiObject Win32_QuickFixEngineering


#インストール済みアプリケーション
header "インストール済みアプリケーション"
$path = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$path1 = "HKLM:" + $path
$path2 = "HKCU:" + $path 
$testpath = @()
$testpath += $path1
if(Test-Path $path2) { $testpath += $path2 }
Get-ChildItem -Path $testpath | 
    %{Get-ItemProperty $_.PsPath} | 
    ?{$_.systemcomponent -ne 1 -and $_.parentkeyname -eq $null} |
    sort displayname | 
    select DisplayName,Publisher


  
