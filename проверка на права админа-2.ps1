$Cred = Get-Credential 
$Computer = (gwmi Win32_ComputerSystem).Name
$User = $Cred.Username
$Pass = $Cred.GetNetworkCredential().Password
$Users = ("$Computer"+"$User")

Add-Type -assemblyname System.DirectoryServices.AccountManagement 
$DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine)
$DS.ValidateCredentials($Users, $pass)

if ($Result -ne "True")
{
<Perform Tasks Here>
}