cls #debug
$Year = Get-Date -Format yyyy
$Year #debug
$mounth = Get-Date -Format MMMM
$mounth
$DayName = Get-Date -Format dddd
$DayName #debug
#проверяем существование папки "год"
$path = "D:\1cBackUps\M" 
$Ypath = $path +"\" +$Year
$Ypath #debug
$isfile = Test-Path $Ypath 
if($isfile -eq "True") {
   Write-host "Папка существует"

}
else {
   Write-host "Файл не существует"
   New-Item $path -Name $Year -Type Directory
   
}
#проверяем существование папки "месяц"
$Mpath = $Ypath+"\"+$mounth 
$path
$Ypath
$Mpath
$isfile = Test-Path $Mpath 
if($isfile -eq "True") {
   Write-host "Папка существует"

}
else {
   Write-host "Файл не существует"
   New-Item $Ypath -Name $mounth -Type Directory
   
}