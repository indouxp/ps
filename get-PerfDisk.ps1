

while ($true) {
	$now = Get-Date -f "yyyyMMdd HHmmss"
	$now
  Get-WmiObject Win32_PerfFormattedData_PerfDisk_LogicalDisk 	|
		Where-Object {$_.Name -eq "C:"}														|
  	Select-Object 					`
  		Name,									`
		  DiskReadBytesPersec,	`
			PercentDiskReadTime,	`
		  DiskWriteBytesPersec,	`
			PercentDiskWriteTime
  Start-Sleep 5
	}

# AvgDiskBytesPerRead
#  Data Type: uint64
#  Access Type: Read Only
# 読み取り操作中にディスクから転送されたバイト数の平均値です。
# 
# 
# AvgDiskBytesPerTransfer
#  Data Type: uint64
#  Access Type: Read Only
# 書き込みまたは読み取り操作中にディスク間で転送されたバイト数の平均値です。
# 
# 
# AvgDiskBytesPerWrite
#  Data Type: uint64
#  Access Type: Read Only
# 書き込み操作中にディスクに転送されたバイト数の平均値です。
# 
# 
# AvgDiskQueueLength
#  Data Type: uint64
#  Access Type: Read Only
# サンプリング間隔中に選択したディスクのキューに入った読み取りおよび書き込み要求の数の平均値です。
# 
# 
# AvgDiskReadQueueLength
#  Data Type: uint64
#  Access Type: Read Only
# サンプリング間隔中に選択したディスクのキューに入った読み取り要求の数の平均値です。
# 
# 
# AvgDisksecPerRead
#  Data Type: uint32
#  Access Type: Read Only
# ディスクからのデータの読み取り時間の平均秒数です。
# 
# 
# AvgDisksecPerTransfer
#  Data Type: uint32
#  Access Type: Read Only
# ディスク転送時間の平均秒数です。
# 
# 
# AvgDisksecPerWrite
#  Data Type: uint32
#  Access Type: Read Only
# ディスクへのデータの書き込み時間の平均秒数です。
# 
# 
# AvgDiskWriteQueueLength
#  Data Type: uint64
#  Access Type: Read Only
# サンプリング間隔中に選択したディスクのキューに入った書き込み要求の数の平均値です。
# 
# 
# Caption
#  Data Type: string
#  Access Type: Read Only
# 統計またはメトリックの簡単な説明 (1 行分の文字列) です。
# 
# 
# CurrentDiskQueueLength
#  Data Type: uint32
#  Access Type: Read Only
# パフォーマンス データの収集時にディスクに残っている要求の数です。この値は、収集時に処理中の要求も含みます。この値は瞬時のスナップショットで、時間間隔での平均値ではありません。複数のスピンドル ディスク デバイスは同時に複数の要求をアクティブにできますが、ほかのコンカレント要求は処理が待機中になります。このカウンターが表示するキューの数値は一時的に高くなったり低くなったりしますが、ディスク ドライブへの負荷が持続している場合、値は常に高くなる傾向にあります。要求は、キューの長さとディスク上のスピンドルの数の差に比例して遅延します。パフォーマンスがよくなるには、この差は平均して 2 より小さくなる必要があります。
# 
# 
# Description
#  Data Type: string
#  Access Type: Read Only
# 統計またはメトリックの説明です。
# 
# 
# DiskBytesPersec
#  Data Type: uint64
#  Access Type: Read Only
# 書き込みまたは読み取り操作中にディスク間でバイトが転送される速度です。
# 
# 
# DiskReadBytesPersec
#  Data Type: uint64
#  Access Type: Read Only
# 読み取り操作中にディスクからバイトが転送される速度です。
# 
# 
# DiskReadsPersec
#  Data Type: uint32
#  Access Type: Read Only
# ディスク上の読み取り操作の速度です。
# 
# 
# DiskTransfersPersec
#  Data Type: uint32
#  Access Type: Read Only
# ディスク上の読み取りおよび書き込み操作の速度です。
# 
# 
# DiskWriteBytesPersec
#  Data Type: uint64
#  Access Type: Read Only
# 書き込み操作中にディスクにバイトが転送される速度です。
# 
# 
# DiskWritesPersec
#  Data Type: uint32
#  Access Type: Read Only
# ディスク上の書き込操作の速度です。
# 
# 
# Frequency_Object
#  Data Type: uint64
#  Access Type: Read Only
# N/A
# 
# 
# Frequency_PerfTime
#  Data Type: uint64
#  Access Type: Read Only
# N/A
# 
# 
# Frequency_Sys100NS
#  Data Type: uint64
#  Access Type: Read Only
# N/A
# 
# 
# Name
#  Data Type: string
#  Access Type: Read Only
# Name プロパティにより、統計またはメトリックを認識するラベルが定義されます。サブクラスの場合、プロパティは上書きされて Key プロパティとなります。
# 
# 
# PercentDiskReadTime
#  Data Type: uint64
#  Access Type: Read Only
# 選択したディスク ドライブが読み取り要求を処理していてビジー状態にあった経過時間の割合をパーセントで表示します。
# 
# 
# PercentDiskTime
#  Data Type: uint64
#  Access Type: Read Only
# 選択したディスク ドライブが読み取りまたは書き込み要求を処理していてビジー状態にあった経過時間の割合をパーセントで表示します。
# 
# 
# PercentDiskWriteTime
#  Data Type: uint64
#  Access Type: Read Only
# 選択したディスク ドライブが書き込み要求を処理していてビジー状態にあった経過時間の割合をパーセントで表示します。
# 
# 
# PercentIdleTime
#  Data Type: uint64
#  Access Type: Read Only
# サンプリング間隔中にディスクがアイドル状態だった時間の割合をパーセントで表示します。
# 
# 
# SplitIOPerSec
#  Data Type: uint32
#  Access Type: Read Only
# ディスクへの I/O が複数の I/O に分割された率をレポートします。分割 I/O は、大きすぎて 1 つの I/O に収まらない、またはディスクが断片化しているサイズのデータを要求することから起こります。
# 
# 
# Timestamp_Object
#  Data Type: uint64
#  Access Type: Read Only
# N/A
# 
# 
# Timestamp_PerfTime
#  Data Type: uint64
#  Access Type: Read Only
# N/A
# 
# 
# Timestamp_Sys100NS
#  Data Type: uint64
#  Access Type: Read Only
# N/A
