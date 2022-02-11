#Get-ADUser -Filter '(sAMAccountName -eq "u2610126")' -Properties l, physicalDeliveryOfficeName | ForEach-Object {Set-ADObject -Identity $_.DistinguishedName ` -Replace @{l=$($_.physicalDeliveryOfficeName)}}
#$otherTelephone =  Get-ADUser -Filter '(sAMAccountName -eq "u2610126")' -Properties l, otherTelephone 
#$otherTelephone


#Get-ADUser -Identity "U2610126" | Set-ADUser -ipPhone "34666"

Get-ADUser -LDAPFilter '(&(!ipphone=*)(otherTelephone=*))' -Properties otherTelephone 

| 
      ForEach-Object{
           Set-ADUser -Identity $_.SamAccountName -Add @{IpPhone=$_.otherTelephone}
     }