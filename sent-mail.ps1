###############################################################################
# メール
# カレントディレクトリのgmail.txtユーザ名、パスワードを取得し、smtp.gmail.com
# からメールする。
#
# Usage:
#   PS> sent-mail DEST-ADDRESS SUBJECT
#   PS> sent-mail DEST-ADDRESS SUBJECT MAILFILE
# ex)
#   PS> sent-mail tatsuo-i@mtb.biglobe.ne.jp テストメール
#   >: 一行目
#   >: 二行目
#   >: .
#   PS>
#   PS> sent-mail tatsuo-i@mtb.biglobe.ne.jp テストメール D:\data\mail.txt
#   PS>
#
###############################################################################
[string]$script:MyPath = $MyInvocation.MyCommand.Path
[string]$script:MyName = $MyInvocation.MyCommand.Name
[string]$hostname = hostname
switch ($hostname) {
  "cf-t9" {
    [string]$script:logDir = "D:\Data\Logs"
    [string]$script:cmnPath = "C:\Users\indou\utils\cmn010.ps1"
  }
  "vipi7920p6t" {
    [string]$script:logDir = "C:\Users\indou\Documents"
    [string]$script:cmnPath = "C:\Users\indou\Documents\GitHub\utils4ps\cmn010.ps1"
  }
}
[string]$destAddress    = $args[0]
[string]$subject        = $args[1]
[string]$content        = $args[2]
[string]$global:logPath = ""
if ($global:logPath -eq "") {
  if (Test-Path $logDir) {
    $logName = $MyName + "." + (get-date -UFormat "%Y%m%d.%H%M%S").toString() + "." + "log"
    $global:logPath = Join-Path $logDir $logName
  } else {
    $logName = $MyName + "." + "log"
    $global:logPath = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) $logName
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
    if ($destAddress -eq "")  {throw "destAddress未定義"}
    if ($subject -eq "")      {throw "subject未定義"}
    # 処理
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

    add2Log "TO:$EmailTo"
    add2Log "SUBJECT:$subject"
    add2Log "BODY:$body"

    add2Log "SUCCESS"
  } catch [Exception] {
    # エラー処理
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
# カレントディレクトリのgmail.txtの内容を取得
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
