
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
#Удаляем пользователя "2"
Remove-LocalUser "2" 
#Переименовываем Администратора и гостя
Rename-LocalUser -Name "Администратор" -NewName "Свой"
Rename-LocalUser -Name "Гость" -NewName "Чужой"

#список всех локальных пользователей
Get-LocalUser
#список всех локальных администраторов
Get-LocalGroupMember -Group "Администраторы"