

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
# �ǂݎ�葀�쒆�Ƀf�B�X�N����]�����ꂽ�o�C�g���̕��ϒl�ł��B
# 
# 
# AvgDiskBytesPerTransfer
#  Data Type: uint64
#  Access Type: Read Only
# �������݂܂��͓ǂݎ�葀�쒆�Ƀf�B�X�N�Ԃœ]�����ꂽ�o�C�g���̕��ϒl�ł��B
# 
# 
# AvgDiskBytesPerWrite
#  Data Type: uint64
#  Access Type: Read Only
# �������ݑ��쒆�Ƀf�B�X�N�ɓ]�����ꂽ�o�C�g���̕��ϒl�ł��B
# 
# 
# AvgDiskQueueLength
#  Data Type: uint64
#  Access Type: Read Only
# �T���v�����O�Ԋu���ɑI�������f�B�X�N�̃L���[�ɓ������ǂݎ�肨��я������ݗv���̐��̕��ϒl�ł��B
# 
# 
# AvgDiskReadQueueLength
#  Data Type: uint64
#  Access Type: Read Only
# �T���v�����O�Ԋu���ɑI�������f�B�X�N�̃L���[�ɓ������ǂݎ��v���̐��̕��ϒl�ł��B
# 
# 
# AvgDisksecPerRead
#  Data Type: uint32
#  Access Type: Read Only
# �f�B�X�N����̃f�[�^�̓ǂݎ�莞�Ԃ̕��ϕb���ł��B
# 
# 
# AvgDisksecPerTransfer
#  Data Type: uint32
#  Access Type: Read Only
# �f�B�X�N�]�����Ԃ̕��ϕb���ł��B
# 
# 
# AvgDisksecPerWrite
#  Data Type: uint32
#  Access Type: Read Only
# �f�B�X�N�ւ̃f�[�^�̏������ݎ��Ԃ̕��ϕb���ł��B
# 
# 
# AvgDiskWriteQueueLength
#  Data Type: uint64
#  Access Type: Read Only
# �T���v�����O�Ԋu���ɑI�������f�B�X�N�̃L���[�ɓ������������ݗv���̐��̕��ϒl�ł��B
# 
# 
# Caption
#  Data Type: string
#  Access Type: Read Only
# ���v�܂��̓��g���b�N�̊ȒP�Ȑ��� (1 �s���̕�����) �ł��B
# 
# 
# CurrentDiskQueueLength
#  Data Type: uint32
#  Access Type: Read Only
# �p�t�H�[�}���X �f�[�^�̎��W���Ƀf�B�X�N�Ɏc���Ă���v���̐��ł��B���̒l�́A���W���ɏ������̗v�����܂݂܂��B���̒l�͏u���̃X�i�b�v�V���b�g�ŁA���ԊԊu�ł̕��ϒl�ł͂���܂���B�����̃X�s���h�� �f�B�X�N �f�o�C�X�͓����ɕ����̗v�����A�N�e�B�u�ɂł��܂����A�ق��̃R���J�����g�v���͏������ҋ@���ɂȂ�܂��B���̃J�E���^�[���\������L���[�̐��l�͈ꎞ�I�ɍ����Ȃ�����Ⴍ�Ȃ����肵�܂����A�f�B�X�N �h���C�u�ւ̕��ׂ��������Ă���ꍇ�A�l�͏�ɍ����Ȃ�X���ɂ���܂��B�v���́A�L���[�̒����ƃf�B�X�N��̃X�s���h���̐��̍��ɔ�Ⴕ�Ēx�����܂��B�p�t�H�[�}���X���悭�Ȃ�ɂ́A���̍��͕��ς��� 2 ��菬�����Ȃ�K�v������܂��B
# 
# 
# Description
#  Data Type: string
#  Access Type: Read Only
# ���v�܂��̓��g���b�N�̐����ł��B
# 
# 
# DiskBytesPersec
#  Data Type: uint64
#  Access Type: Read Only
# �������݂܂��͓ǂݎ�葀�쒆�Ƀf�B�X�N�ԂŃo�C�g���]������鑬�x�ł��B
# 
# 
# DiskReadBytesPersec
#  Data Type: uint64
#  Access Type: Read Only
# �ǂݎ�葀�쒆�Ƀf�B�X�N����o�C�g���]������鑬�x�ł��B
# 
# 
# DiskReadsPersec
#  Data Type: uint32
#  Access Type: Read Only
# �f�B�X�N��̓ǂݎ�葀��̑��x�ł��B
# 
# 
# DiskTransfersPersec
#  Data Type: uint32
#  Access Type: Read Only
# �f�B�X�N��̓ǂݎ�肨��я������ݑ���̑��x�ł��B
# 
# 
# DiskWriteBytesPersec
#  Data Type: uint64
#  Access Type: Read Only
# �������ݑ��쒆�Ƀf�B�X�N�Ƀo�C�g���]������鑬�x�ł��B
# 
# 
# DiskWritesPersec
#  Data Type: uint32
#  Access Type: Read Only
# �f�B�X�N��̏���������̑��x�ł��B
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
# Name �v���p�e�B�ɂ��A���v�܂��̓��g���b�N��F�����郉�x������`����܂��B�T�u�N���X�̏ꍇ�A�v���p�e�B�͏㏑������� Key �v���p�e�B�ƂȂ�܂��B
# 
# 
# PercentDiskReadTime
#  Data Type: uint64
#  Access Type: Read Only
# �I�������f�B�X�N �h���C�u���ǂݎ��v�����������Ă��ăr�W�[��Ԃɂ������o�ߎ��Ԃ̊������p�[�Z���g�ŕ\�����܂��B
# 
# 
# PercentDiskTime
#  Data Type: uint64
#  Access Type: Read Only
# �I�������f�B�X�N �h���C�u���ǂݎ��܂��͏������ݗv�����������Ă��ăr�W�[��Ԃɂ������o�ߎ��Ԃ̊������p�[�Z���g�ŕ\�����܂��B
# 
# 
# PercentDiskWriteTime
#  Data Type: uint64
#  Access Type: Read Only
# �I�������f�B�X�N �h���C�u���������ݗv�����������Ă��ăr�W�[��Ԃɂ������o�ߎ��Ԃ̊������p�[�Z���g�ŕ\�����܂��B
# 
# 
# PercentIdleTime
#  Data Type: uint64
#  Access Type: Read Only
# �T���v�����O�Ԋu���Ƀf�B�X�N���A�C�h����Ԃ��������Ԃ̊������p�[�Z���g�ŕ\�����܂��B
# 
# 
# SplitIOPerSec
#  Data Type: uint32
#  Access Type: Read Only
# �f�B�X�N�ւ� I/O �������� I/O �ɕ������ꂽ�������|�[�g���܂��B���� I/O �́A�傫������ 1 �� I/O �Ɏ��܂�Ȃ��A�܂��̓f�B�X�N���f�Љ����Ă���T�C�Y�̃f�[�^��v�����邱�Ƃ���N����܂��B
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
