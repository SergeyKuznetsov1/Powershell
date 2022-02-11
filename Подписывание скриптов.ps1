[CmdletBinding()]
Param
(
[parameter(Mandatory=$true)]
[string]$FilePath
)
$cert = @(Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)[0]
$cert
Set-AuthenticodeSignature -Certificate $cert -FilePath $FilePath -TimestampServer 'http://timestamp.comodoca.com/authenticode'