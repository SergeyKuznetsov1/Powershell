set-executionpolicy -executionpolicy remotesigned -scope localmachine



write "#####################"
write "###  0.  Имя ПК   ###"
write "#####################"

write $env:COMPUTERNAME


########################################
# 1.  Проверка есть ли пароль на BIOS  #
########################################

write "##########################################"
write "###  Проверка есть ли пароль на BIOS   ###"
write "##########################################"

$BIOSpasswordState = (gwmi -Class Lenovo_BiosPasswordSettings -Namespace root\wmi).PasswordState
$BIOSpasswordState
if ($BIOSpasswordState -eq 2){
    Write-Host "Пароль есть"
}
else{
    Write-Host "Пароля нет"
}



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
write "#############################################"
write "### Cписок всех локальных администраторов ###"
write "#############################################"
Get-LocalGroupMember -Group "Администраторы"

###########################################



###########################################
# удаляем  все таски
###########################################
write "###################################"
write "### Выводим список всех заданий ###"
write "###################################"

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
Write-Host ("Есть ТАСК !!! "+$Task.Name  )
###$TaskFolder.DeleteTask($Task.Name,0)
}

###########################################
# тормозим SSDP
###########################################
write "#####################################"
write "### Выводим состояние службы SSDP ###"
write "#####################################"

#Выбираем службу
$srv = Get-Service SSDPSRV
wRITE $srv.Status 
wRITE $srv.StartType



set-executionpolicy -executionpolicy restricted -scope localmachine