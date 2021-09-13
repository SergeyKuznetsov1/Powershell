Import-Module activedirectory
Import-Csv "C:\Users\A00108\Documents\add_new_user\222.csv" -Delimiter ';' | ForEach-Object {
$upn = $_.SamAccountName + “@gzf.local”
$uname = $_.LastName + " " + $_.FirstName
$upn
$_.SamAccountName 
$uname
$_.FirstName
$_.LastName
$_.Initials
$_.Phone
$_.Department
$_.JobTitle
$_.OU 

New-ADUser -Name $uname `
-DisplayName $uname `
-GivenName $_.FirstName `
-Surname $_.LastName `
-Initials $_.Initials `
-OfficePhone $_.Phone `
-Department $_.Department `
-Title $_.JobTitle `
-UserPrincipalName $upn `
-SamAccountName $_.samAccountName `
-Path $_.OU `
-AccountPassword (ConvertTo-SecureString $_.Password -AsPlainText -force) -Enabled $true
}
