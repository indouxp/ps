###############################################################################
# �\�[�X�̓ǂݍ���
#
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyDir = $MyPath -replace "\\[^\\]+$", ""
[string]$Module = $MyDir + "\" + "mod080.ps1"

Import-Module $Module

$message = "�e�X�g�J�n"
$rc = insert_message -status 0 -facility "ps1" -priority 0 -message $message
if ($rc -ne 0) {
	Write-Host $message
  exit $rc
}

$message = "�e�X�g�I��"
$rc = insert_message -status 0 -facility "ps1" -priority 0 -message $message
if ($rc -ne 0) {
	Write-Host $message
	exit $rc
}

select_messages
