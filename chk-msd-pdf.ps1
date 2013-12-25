###############################################################################
# C:\Users\indou\Pictures\Release以下のpdfと、MicroSDのpdfをチェックする 
#
#
###############################################################################
Param(
  [string]$action = "list"
)
###############################################################################
function main{
###############################################################################
  $srcs = @()
  $dests = @()
  get-list -dirname "C:\Users\indou\Pictures\Release" -ref_length_list ([ref]$srcs)
  get-list -dirname "G:\pdf" -ref_length_list ([ref]$dests)

  ########################################  
  # ファイル名とサイズを取得
  ########################################  
  $src_length_list = @{}
  foreach ($file_object in $srcs) {
    $src_length_list[$file_object.Name] = $file_object.Length
  }
  $dest_length_list = @{}
  foreach ($file_object in $dests) {
    $dest_length_list[$file_object.Name] = $file_object.Length
  }
  ########################################  
  # ソースリストをすべて処理
  ########################################  
  $src_length_list.getEnumerator() | sort key | Foreach {
    if ($dest_length_list[$_.key]) {
      if ($src_length_list[$_.key] -eq $dest_length_list[$_.key]) {
        $result = "○:" +
                  $_.key + " " +
                  $dest_length_list[$_.key]
      } else {
        $result = "△:" +
                  $_.key + " " +
                  $src_length_list[$_.key] + " " +
                  $dest_length_list[$_.key]
      }
    } else {
      $result = "×:" +
                $_.key
    }
    $result
  }
  $msg = @"
---------------------------------------
○:いずれにも存在し、サイズも一致
△:いずれにも存在するが、サイズが不一致
×:Micro SDには存在しない。
"@
  $msg
}
###############################################################################
function get-list {
###############################################################################
  Param(
    [string]$dirname,
    [ref]$ref_length_list
  )
  $hash = get-childitem $dirname
  $ref_length_list.Value = get-childitem $dirname
}

###############################################################################
Set-PSDebug -strict
main
exit 0
