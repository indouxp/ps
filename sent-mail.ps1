###############################################################################
# ���[��
#
# Usage:
#   PS> sent-mail DEST SUBJECT
#   PS> sent-mail DEST SUBJECT MAILFILE
# ex)
#   PS> sent-mail tatsuo-i@mtb.biglobe.ne.jp �e�X�g���[��
#   >: ��s��
#   >: ��s��
#   >: .
#   PS>
#   PS> sent-mail tatsuo-i@mtb.biglobe.ne.jp �e�X�g���[�� D:\data\mail.txt
#   PS>
#
###############################################################################
[string]$script:MyPath = $MyInvocation.MyCommand.Path
[string]$script:MyName = $MyInvocation.MyCommand.Name
[string]$script:logDir = "D:\Data\Logs"
[string]$script:cmnPath = "C:\Users\indou\utils\cmn010.ps1"
[string]$destAddress    = $args[0]
[string]$subject        = $args[1]
[string]$content        = $args[2]
[string]$global:logPath
if ($logPath -eq "") {
  if (Test-Path $logDir) {
    $logName = $MyName + "." + (get-date -UFormat "%Y%m%d.%H%M%S").toString() + "." + "log"
    $logPath = Join-Path $logDir $logName
  } else {
    $logName = $MyName + "." + "log"
    $logPath = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) $logName
  }
}
###############################################################################
. $cmnPath
$ErrorActionPreference = "Stop"
trap {
  $msg = "TRAP:" + $Error[0]
	Write-Host $msg
  add2Log $msg
	break
}
###############################################################################
function main {
  try {
    add2Log "START"
    if ($destAddress -eq "")  {throw "destAddress����`"}
    if ($subject -eq "")      {throw "subject����`"}
    # ����
    $userPass = @()
    getUserPass([ref]$userPass)

    if ($content -ne "" -and (Test-Path $content) -eq $true) {
      $body = ""
      $line = ""
      $enc = [Text.Encoding]::GetEncoding("Shift_JIS")
      $fileHandler = New-Object System.IO.StreamReader($content, $enc)
      while (($line = $fileHandler.ReadLine()) -ne $null) {
        $body += $line + "`n"
      }
      $fileHandler.close()
    } else {
      $line = ""
      $body = ""
      $line = Read-Host ">" 
      while ($line -ne ".") {
        $body += $line + "`n"
        $line = Read-Host -Prompt ">" 
      }
    }

    $SMTPServer = "smtp.gmail.com" 
    $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
    $SMTPClient.EnableSsl = $true 
    $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($userPass[0], $userPass[1])
    $EmailFrom = $userPass[0]
    $EmailTo = $destAddress
    $SMTPClient.Send($EmailFrom, $EmailTo, $subject, $body)

    add2Log "SUCCESS"
  } catch [Exception] {
    # �G���[����
    $msg = "CATCH:" + $Error[0]
		Write-Host $msg
    add2Log $msg
    exit 1
  } finally {
    add2Log "DONE"
  }
  exit 0
}
###############################################################################
# �J�����g�f�B���N�g����gmail.txt�̓��e���擾
function getUserPass {
  Param([ref]$ref_userpass)
  $pwd = (Get-Location).ToString()
  $gmailAccounts = $pwd + "\" + "gmail.txt"
  $ref_userpass.Value = Get-Content $gmailAccounts
}
###############################################################################
Set-PSDebug -strict
###############################################################################
if ($args.length -ne 0) {
	main $args
} else {
	usage $MyInvocation.MyCommand.Path
}