# скрипт создания архивных копий 1с баз
# проверяем есть ли пути для сохранения
$CurrentYear = Get-Date -Format yyyy
#Путь до архивов + текущий год
$fpath = "\\fserver3\Backups\1c bases\M\"+$CurrentYear
$isfile = Test-Path $fpath 

if($isfile -eq "True") {
   Write-host "Файл существует"
}
else {
   Write-host "Файл не существует"
}