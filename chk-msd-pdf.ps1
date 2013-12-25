###############################################################################
# C:\Users\indou\Pictures\Release�ȉ���pdf�ƁAMicroSD��pdf���`�F�b�N���� 
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
  # �t�@�C�����ƃT�C�Y���擾
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
  # �\�[�X���X�g�����ׂď���
  ########################################  
  $src_length_list.getEnumerator() | sort key | Foreach {
    if ($dest_length_list[$_.key]) {
      if ($src_length_list[$_.key] -eq $dest_length_list[$_.key]) {
        $result = "��:" +
                  $_.key + " " +
                  $dest_length_list[$_.key]
      } else {
        $result = "��:" +
                  $_.key + " " +
                  $src_length_list[$_.key] + " " +
                  $dest_length_list[$_.key]
      }
    } else {
      $result = "�~:" +
                $_.key
    }
    $result
  }
  $msg = @"
---------------------------------------
��:������ɂ����݂��A�T�C�Y����v
��:������ɂ����݂��邪�A�T�C�Y���s��v
�~:Micro SD�ɂ͑��݂��Ȃ��B
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
