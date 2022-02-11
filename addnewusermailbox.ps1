
#Меняем цвет предупреждений
$Host.PrivateData.WarningForegroundColor = 'green'
Write-Warning ''
$Host.PrivateData.ErrorBackgroundColor = 'black'
$Host.PrivateData.ErrorForegroundColor = 'yellow'

#----------------------------------------------MS Exchange Server 2016--------------------------------------------------#
#Производим подключение к серверу Exchnage 2016
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://A8D1-EXC-01.gzf.local/PowerShell/ -Authentication Kerberos

#Перехватываем сессию Exchange Shell
Import-PSSession $Session


New-Mailbox -UserPrincipalName "V.Golynskiy@gzf.local"  `
 -Alias V.Golynskiy `
 -Database "gzf_base_default" `
 -Name "Голынский Валерий Павлович" `
 -OrganizationalUnit "gzf.local/GZF/Users/Company employees" ` 
 -FirstName "Валерий Павлович" `
 -LastName "Голынский" `
 -ResetPasswordOnNextLogon $True `
 -Password (ConvertTo-SecureString -String '111qqqAAA' -AsPlainText -Force) 

 
 
 ##New-Mailbox -Name <Name> -UserPrincipalName <UPN> -Password (ConvertTo-SecureString -String '<Password>' -AsPlainText -Force) [-Alias <Alias>] [-FirstName <FirstName>] [-LastName <LastName>] [-DisplayName <DisplayName>] -[OrganizationalUnit <OU>]