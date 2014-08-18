###############################################################################
# google����
# http://d.hatena.ne.jp/coma2n/20090305/1236253258
#
#
###############################################################################
Param(
  [string]$logPath = $MyInvocation.MyCommand.Path + ".log",
	[string]$word = ""
)
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
###############################################################################
$ErrorActionPreference = "Stop"
trap {
  $msg = "TRAP:" + $Error[0]
	Write-Host $msg
  toLog $msg
	break
}
###############################################################################
function main {
  try {
    toLog "START"
    # ����
    
		$word
		Start-Sleep 1

    # $word���AASCII�R�[�h�ɕϊ�
   	[void]([Reflection.Assembly]::LoadWithPartialName("System.Web"))
		$word = [Web.HttpUtility]::UrlEncode($word) 

		# google�Ō���
		$webReq = [Net.HttpWebRequest]::Create("http://www.google.co.jp/search?hl=ja&q=$word")
		$webReq.Method = "GET"
		$webReq.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)"

		# ���X�|���X�̎擾
		$webRes = $webReq.GetResponse()
		$sr = New-Object IO.StreamReader($webRes.GetResponseStream(), $webRes.ContentEncoding)
		$content = $sr.ReadToEnd()
		$sr.Close()
		$webRes.Close()

		# ���s���폜
		$content = $content -replace "`n", ""
		# �X�N���v�g�ƃX�^�C�����폜
		$content = $content -replace "<(script|style)>.*?", ""
		toLog $content
		$ptn = New-Object Text.RegularExpressions.Regex("<li class=`"g`">(?<line>.*?)</(div|table)>")
		$m = $ptn.Matches($content)
		$m | % {
      if($_.Value -match '<h3 class=r><a href=\"(?<url>.*?)\" .*?>(?<title>.*?)</a>') {
        $obj = New-Object PSObject
        # �^�C�g��
        $obj | Add-Member NoteProperty Title ($matches.title -replace "</*\w*>", "")
        # URL
        $obj | Add-Member NoteProperty Url $matches.url
        $obj
      }
    }

    toLog "SUCCESS"
  } catch [Exception] {
    # �G���[����
    $msg = "CATCH:" + $Error[0]
		Write-Host $msg
    toLog $msg
    exit 1
  } finally {
    toLog "DONE"
  }
  exit 0
}
###############################################################################
function toLog {
  Param([string]$msg = "")
  $now = get-date -uFormat "%Y/%m/%d %H:%M:%S"
  $now + ":" + "[" + $PID + "]" + " " + $msg |
    Out-File $script:$logPath -encoding Default -append -ErrorAction Stop
}
###############################################################################
Set-PSDebug -strict
main
