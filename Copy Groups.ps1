## Новая группа
$newGrpName = "Res.OtdelOAR.RW"
$existingGrpName = "098_OtdelOAR_RW"
$grpScope = "Global"



$description = Get-ADGroup $existingGrpName -properties * | ft description | out-string 
$grpCat = "Security"
$path = "OU=Groups,OU=Metrology,DC=corp,DC=mrgeng,DC=ru"
## исходная группа

 
New-ADGroup -name $newGrpName -GroupScope $grpScope -Description $description -GroupCategory `
$grpCat -Path $path -PassThru  | Add-ADGroupMember -Members (Get-ADGroupMember $existingGrpName) `
-PassThru | Get-ADGroupMember | Select Name