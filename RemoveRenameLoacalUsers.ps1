
set-executionpolicy -executionpolicy remotesigned -scope localmachine

########################################
# 1.  Проверка есть ли пароль на BIOS  #
########################################

write "##############################################"
write "###  1.  Проверка есть ли пароль на BIOS   ###"
write "##############################################"

$BIOSpasswordState = (gwmi -Class Lenovo_BiosPasswordSettings -Namespace root\wmi).PasswordState
$BIOSpasswordState
if ($BIOSpasswordState -eq 2){
    Write-Host "Пароль есть"
}
else{
    Write-Host "Пароля нет"
}


 
################################
# 2.  Удаляем пользователя "2" #
################################
write "#####################################"
write "### 2. Удаляем пользователя [2]   ###"
write "#####################################"
Remove-LocalUser "2" 


##############################################
# 3. Переименовываем Администратора и гостя  #
##############################################
Rename-LocalUser -Name "Администратор" -NewName "Свой"
Rename-LocalUser -Name "Гость" -NewName "Чужой"

##########################################
#  список всех локальных пользователей   #
##########################################
write "##########################################"
write "## Cписок всех локальных пользователей: ##"
write "##########################################"
Get-LocalUser

###########################################
#список всех локальных администраторов
###########################################
write "Cписок всех локальных администраторов"
Get-LocalGroupMember -Group "Администраторы"

###########################################



###########################################
# удаляем  все таски
###########################################
# create Task Scheduler COM object
$TS = New-Object -ComObject Schedule.Service
# connect to local task sceduler
$TS.Connect($env:COMPUTERNAME)
# get tasks folder (in this case, the root of Task Scheduler Library)
$TaskFolder = $TS.GetFolder("\")
# get tasks in folder
$Tasks = $TaskFolder.GetTasks(1)
## define name of task to delete
##$TaskToDelete = "MyTask"
# step through all tasks in the folder
foreach($Task in $Tasks){
Write-Host ("Task "+$Task.Name+" will be removed")
$TaskFolder.DeleteTask($Task.Name,0)
}

###########################################
# тормозим SSDP
###########################################

#Выбираем службу
$srv = Get-Service SSDPSRV
 
#Останавливаем если запущена служба 
if ($srv.Status -eq 'Running'){
    Stop-Service -Name "SSDPSRV"
}
#Изменяем тип запуска на - "отключена"
Set-Service -Name "SSDPSRV" -StartupType Disabled



set-executionpolicy -executionpolicy restricted -scope localmachine