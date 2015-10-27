
function start_header()
{
  Write-Output "===================="
  Write-Output "OS���"
  $date = Get-Date
  Write-Output "�J�n����:$date"
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

#�z�X�g��
header "�z�X�g��"
hostname


#OS�o�[�W����
header "OS�o�[�W����"
[Environment]::OSVersion | fl


#�f�B�X�N�\��
header "�f�B�X�N�\��"
Get-WmiObject Win32_DiskDrive


#�h���C���Q�����
header "�h���C���Q�����"
$domain = (Get-WMIObject Win32_ComputerSystem).PartOfDomain
if($domain)
{
  Write-Output "joined to Domain."
} else {
  Write-Output "not joined to Domain(WORKGROUP)."
}
Get-WmiObject Win32_ComputerSystem


#�l�b�g���[�N�ݒ�
header "�l�b�g���[�N�ݒ�"
#Get-WmiObject Win32NetworkAdapterConfiguration
ipconfig /all


#�������A�@�\���
header "�������A�@�\���"
Import-Module ServerManager
Get-WindowsFeature


#�K�p�ς݃Z�L�����e�B�p�b�`
header "�K�p�ς݃Z�L�����e�B�p�b�`"
Get-WmiObject Win32_QuickFixEngineering


#�C���X�g�[���ς݃A�v���P�[�V����
header "�C���X�g�[���ς݃A�v���P�[�V����"
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


  
