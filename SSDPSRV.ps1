#Выбираем службу
$srv = Get-Service SSDPSRV
 
#Останавливаем если запущена служба 
if ($srv.Status -eq 'Running'){
    Stop-Service -Name "SSDPSRV"
}
#Изменяем тип запуска на - "отключена"
Set-Service -Name "SSDPSRV" -StartupType Disabled
