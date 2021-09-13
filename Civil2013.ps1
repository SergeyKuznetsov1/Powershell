$result = cmd.exe /c D:\lmutil.exe lmstat -c "@SERVICESERVER" -f 85992IDSP_2013_0F
[string]$UserName = $result -like "*start*"
powershell (New-Object -ComObject Wscript.Shell).Popup($UserName ,0,"""A вот кто запустил Civil 2013""",0x0)