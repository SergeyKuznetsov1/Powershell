#Вводим ФИО в формате "Фамилия Имя Отчество"
#===============================================
$string_to_convert = "Попов Сергей Викторович"
#
#===============================================
$LogonName = "S.Popov"
#===============================================
#Парсим ФИО в Фамилию, Имя и Отчество
$first_name = $string_to_convert.Split("")[1]
$middle_name = $string_to_convert.Split("")[2]
$surname1 = $string_to_convert.Split("")[0]

#===============================================
$Office = "4311 БЦ Эриксонъ"
$Department ="Отдел производственного аудита"
#===============================================
#===============================================

$ou = "OU=Company employees,OU=Users,OU=GZF,DC=gzf,DC=local"
$DisplayName = $string_to_convert
$GivenName =$first_name +' '+ $middle_name 
$Surname = $surname1
$userPrincipalName = $LogonName +"@gzf.local"
$City = "Санкт-Петербург"
$StreetAddress = "Большой Сампсониевский пр., д. 60 лит. А"
$pass = ConvertTo-SecureString -String "111qqqAAA" -AsPlainText -Force
$State = "Газпром газификация"
$Description = "Газпром газификация"
$OfficePhone = "(707)xxxxx"
$PostalCode = "194044"
$Company = "ООО `″Газпром газификация`″"
$title = "Начальник отдела"

New-ADUser -Path $ou `
 -Name $LogonName `
 -GivenName $GivenName `
 -OfficePhone $OfficePhone `
 -Office $Office `
 -PostalCode $PostalCode `
 -Surname $Surname `
 -Company $Company `
 -AccountPassword $pass `
 -Enabled $true `
 -UserPrincipalName $userPrincipalName `
 -DisplayName $DisplayName `
 -Description $Description `
 -City $City `
 -Department $Department `
 -StreetAddress $StreetAddress `
 -State $State `
 -OtherAttributes @{'title'=$title}