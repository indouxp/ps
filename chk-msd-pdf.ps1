###############################################################################
# Pictures\Release以下のpdfと、MicroSDのpdfをチェックする 
#
#
###############################################################################
Param(
  [string]$action = "list"
)
###############################################################################
function main{
  $srcs = @()
  $dests = @()
  get-list -dirname "C:\Users\indou\Pictures\Release" -ref_lists ([ref]$srcs)
  get-list -dirname "G:\pdf" -ref_lists ([ref]$dests)

  $src_lists = @{}
  foreach ($list in $srcs) {
    $src_lists[$list.Name] = $list.Length
  }
  $dest_lists = @{}
  foreach ($list in $dests) {
    $dest_lists[$list.Name] = $list.Length
  }
  $src_lists.getEnumerator() | sort key | Foreach {
    if ($dest_lists[$_.key]) {
      if ($src_lists[$_.key] -eq $dest_lists[$_.key]) {
        Write-Host "OK  " $_.key $dest_lists[$_.key]
      } else {
      Write-Host "SIZE" $_.key $src_lists[$_.key] $dest_lists[$_.key]
      }
    } else {
      Write-Host "NG  " $_.key
    }
  }
}
###############################################################################
function get-list {
  Param(
    $dirname,
    [ref]$ref_lists
  )
  $hash = get-childitem $dirname
  $ref_lists.Value = get-childitem $dirname
}

###############################################################################
Set-PSDebug -strict
main
