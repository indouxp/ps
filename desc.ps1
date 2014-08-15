Param(
	[string] $table = "tbl_messages"
)

$server_name = ".\sqlexpress"
$database = "tsystem"
#$query = "exec sp_columns tbl_messages"
#$table = "TBL_MESSAGES"
$log = "d:\tmp\desc.log"

Write-Host "[$table]"

# http://msdn.microsoft.com/ja-jp/library/ms186816.aspx
$query = @"
	select
		sysobjects.name,
		syscolumns.name,
		systypes.name,
		syscolumns.length 
	from
		syscolumns 
			inner join
				sysobjects
			on
				sysobjects.id = syscolumns.id
			inner join
				systypes
			on
				syscolumns.xtype = systypes.xtype
	where
		sysobjects.name = '$table'
	order by
		syscolumns.colid
"@

# -E �Z�L�����e�B�ڑ�
# -S �T�[�o�[
# -d �f�[�^�x�[�X
# -Q �N�G���[���s��I��
# -u ���j�R�[�h�o��
# -b �G���[���Ƀo�b�`�𒆎~
# -w �\����
# -W �㑱�̃X�y�[�X���폜
sqlcmd -E -S $server_name -d $database -Q $query -u -b -w 80 -W > $log
exit $LASTEXITCODE

