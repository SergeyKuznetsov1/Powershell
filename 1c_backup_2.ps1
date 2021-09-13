# чистим экран)
cls 

#Ежедневное архивирование БД 1c сервера

# это создаем временный массив, для удаления в массиве версий 1с-платформ
$tmp =@()

#указываем путь для сохранения бэкапов
$directory = "\\fserver3\Backups\1C_Backups\MORION\Auto\daily\"

#создание массива с версиями 1с-платформ
$1cversions = dir "C:\Program Files\1cv8" | Select Name

#в массиве убираем "common" и "conf" и всё сохраняем в массив tmp
foreach ($element in $1cversions){
   If (($element.Name -ne 'common') -and ($element.Name -ne 'conf'))
       { $tmp += $element}
   }

# выбираем максиамльную версию
$tmp | sort 

#узнаем текущий день недели
$date = Get-Date -Format dddd

#Формируем путь к 1cv8.exe
$path="C:\Program Files\1cv8\" + $tmp.name[-1] + "\bin\"

$a = "Кавычки `"внутри`" кавычек"
$a
$exe = " $path + "1cv8.exe"

$config = " CONFIG /F D:\root\base\accounting\M\3.0 /N update /P 1sbase /DumpIB"
$exe
$config
$directory

###  & $exe $config $directory

#$path + " CONFIG /F D:\root\base\accounting\M\3.0 /N update /P 1sbase /DumpIB"+$directory


# "C:\Program Files\1cv8\8.3.11.2954\bin\1cv8.exe" CONFIG /F D:\root\base\accounting\M\3.0 /N update /P 1sbase /DumpIB"D:\1cBackUps\M\%date:~6,4%\%date:~3,2%\M_%date%.dt"