$sourceDirPath = 'D:\--From'
$destDirPath = 'D:\--To'

$sourceDirInfo = New-Object IO.DirectoryInfo($sourceDirPath)
$destDirInfo = New-Object IO.DirectoryInfo($destDirPath)

$directorySecurity = $sourceDirInfo.GetAccessControl([System.Security.AccessControl.AccessControlSections]:: Access)
$destDirInfo.SetAccessControl($directorySecurity)