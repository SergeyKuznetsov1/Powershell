Import-Module activedirectory

Import-Csv "C:\Users\A00108\Documents\222.csv" -Delimiter ';' | ForEach-Object {
$upn = $_.SamAccountName
$upn
$uname
$_.Phone

set-aduser -Identity $upn -OfficePhone $_.Phone
}