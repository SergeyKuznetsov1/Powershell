Function Get-Folder() 
{
    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')|Out-Null
    $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowserDialog.RootFolder = 'MyComputer'
    if ($FolderBrowserDialog.ShowDialog() -eq "OK")
    {
        return $FolderBrowserDialog.SelectedPath
    }
    return $null
}

if($sourceDirPath = Get-Folder)
{    
    if($destDirPath = Get-Folder)
    {
        $sourceDirInfo = New-Object IO.DirectoryInfo($sourceDirPath)
        $sourceDirectorySecurity = $sourceDirInfo.GetAccessControl()

        $destDirInfo = New-Object IO.DirectoryInfo($destDirPath)
        $destDirectorySecurity = $destDirInfo.GetAccessControl()

        $form = $sourceDirectorySecurity.GetSecurityDescriptorBinaryForm()
        $destDirectorySecurity.SetSecurityDescriptorBinaryForm($form)

        $destDirInfo.SetAccessControl($destDirectorySecurity)
    }
}
