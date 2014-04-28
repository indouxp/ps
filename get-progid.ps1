# http://gallery.technet.microsoft.com/scriptcenter/ce929426-71fc-4740-b8f1-b78ba1ba3b15
# インストールされているComのProgIDを取得する。
Get-WmiObject -Class Win32_ProgIDSpecification |  
Format-Table -Property ProgID, description -AutoSize 
