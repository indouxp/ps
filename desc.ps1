
$server_name = ".\sqlexpress"
$database = "tsystem"
#$query = "exec sp_columns tbl_messages"
$table = "TBL_MESSAGES"

# http://msdn.microsoft.com/ja-jp/library/ms186816.aspx
$query = @"
select
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

# -E セキュリティ接続
# -S サーバー
# -d データベース
# -Q クエリー実行後終了
# -u ユニコード出力
# -b エラー時にバッチを中止
# -w 表示幅
# -W 後続のスペースを削除
sqlcmd -E -S $server_name -d $database -Q $query -u -b -w 80 -W
exit $LASTEXITCODE
