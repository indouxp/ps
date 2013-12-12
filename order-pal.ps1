###############################################################################
# カレントディレクトリの、pal.txtを読み込み、
# shop.pal-system.co.jpにログインし、処理を行う。
#
###############################################################################
Param(
  [string]$logPath = $MyInvocation.MyCommand.Path + ".log"
)
. .\func-log.ps1
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyName = $MyInvocation.MyCommand.Name
###############################################################################
# 主処理
function main {
  try {
    toLog("START")
    $userPass = @()
    getUserPass([ref]$userPass)
    $ie = new-object -com "InternetExplorer.Application"
    $login_url = "https://shop.pal-system.co.jp/pal/SilverStream/Pages/pgIpalLogin.html?PROC_DIV=1"
    $ie.navigate($login_url)
    $ie.visible = $true
    while($ie.Busy) { Start-Sleep -milliseconds 100 }
    $doc = $ie.document
    $user = $doc.getElementById("loginId")
    $pass = $doc.getElementById("password")
    $user.Value = $userPass[0]
    $pass.Value = $userPass[1]
    $discover_login = $false
    $login_button = ""
    foreach ($button in $doc.getElementsByTagName("INPUT")) {
      # タグ名がinputの要素の中で、altと、srcを指定してログインボタンを発見する。
      if ($button.alt -eq "ログイン" -and 
          $button.src -eq "https://shop.pal-system.co.jp/pal/common/img/button-login_01_off.gif") {
        $discover_login = $true
        $login_button = $button
      }
    }
    if ($discover_login -eq $false) {
      throw "aタグ内に、注文番号記入への参照が見つかりません。"
    }
    $login_button.click()
    while($ie.Busy) { Start-Sleep -milliseconds 100 }
    $doc = $ie.document
    $discover_anchor = $false
    $order_anchor = ""
    foreach ($anchor in $doc.getElementsByTagName("a")) {
      if ($anchor.href -eq "https://shop.pal-system.co.jp/pal/NumberOrder.do") {
        $discover_anchor = $true
        $order_anchor = $anchor
      }
    }
    if ($discover_anchor -eq $false) {
      throw "ログインボタンが見つかりません"
    }
    $order_anchor.click()
    toLog("ok")
    Start-Sleep 5
    toLog("quit")
    #$ie.quit()
    toLog("SUCCESS")
  } catch [Exception] {
    # エラー処理
    toLog("ERROR:" + $Error )
    exit 1
  } finally {
    toLog("DONE")
  }
  exit 0
}
###############################################################################
# カレントディレクトリのpal.txtの内容を取得
function getUserPass {
  Param([ref]$ref_userpass)
  $pwd = (Get-Location).ToString()
  $pal = $pwd + "\" + "pal.txt"
  $ref_userpass.Value = Get-Content $pal
}
###############################################################################
Set-PSDebug -strict
main
