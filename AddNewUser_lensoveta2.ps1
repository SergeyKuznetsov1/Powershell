$ou = "OU=Users,OU=Metrology,DC=corp,DC=mrgeng,DC=ru"
$LogonName = "U2610256"
$DisplayName = "Гринченко Елена Викторовна"
$GivenName = "Елена Викторовна"
$Surname = "Гринченко"
$userPrincipalName = "U2610256@corp.mrgeng.ru"
$Office = "Санкт-Петербург, ул. Ленсовета, д. 58"
$Department ="Казначейская группа"
$City = "Санкт-Петербург"
$StreetAddress = "ул. Ленсовета, д. 58"
$pass = ConvertTo-SecureString -String "Metrolog1" -AsPlainText -Force
$State = "Инжиниринг"
$Description = "Газпром межрегионгаз инжиниринг"
$OfficePhone = ""
$PostalCode = ""
$Company = "ООО `″Газпром межрегионгаз инжиниринг`″"
$title = "Специалист 1 категории"

New-ADUser -Path $ou `
-Name $DisplayName `
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
-OtherAttributes @{'title'=$title} `
-SamAccountName $LogonName 