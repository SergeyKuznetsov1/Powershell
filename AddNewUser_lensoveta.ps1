$ou = "OU=Users,OU=Metrology,DC=corp,DC=mrgeng,DC=ru"
$LogonName = "U2610236"
$DisplayName = "Курбангалин Ильгиз Расульевич"
$GivenName = "Ильгиз Расульевич"
$Surname = "Курбангалин"
$userPrincipalName = "U2610236@corp.mrgeng.ru"
$Office = "г. Пермь ул. Карпинского, д. 99 Г"
$Department ="Пермский участок сервиса"
$City = "г. Пермь"
$StreetAddress = "ул. Карпинского, д. 99 Г"
$pass = ConvertTo-SecureString -String "Metrolog1" -AsPlainText -Force
$State = "Инжиниринг"
$Description = "Газпром межрегионгаз инжиниринг"
$OfficePhone = ""
$PostalCode = ""
$Company = "ООО `″Газпром межрегионгаз инжиниринг`″"
$title = "Заместитель начальника отделения"

New-ADUser -Path $ou -Name $LogonName -GivenName $GivenName -OfficePhone $OfficePhone -Office $Office -PostalCode $PostalCode -Surname $Surname -Company $Company -AccountPassword $pass -Enabled $true -UserPrincipalName $userPrincipalName -DisplayName $DisplayName -Description $Description -City $City -Department $Department -StreetAddress $StreetAddress -State $State -OtherAttributes @{'title'=$title}