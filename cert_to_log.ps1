# Get all certs from "MY" container and put them to log file in   


$date = Get-Date -Format ddMMyyyy
$Filename = $env:username +'_' + $date +'.log'

$FilePath = '\\M-FS01-r1\Cert_Logs'+"`$"+"\logs\"

$FilePath_full = $FilePath + $Filename

$certs = gci Cert:\CurrentUser\My | format-list | Out-File -Force -FilePath $FilePath_full
