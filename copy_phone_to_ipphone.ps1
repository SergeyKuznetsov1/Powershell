
#Get-ADUser -Identity "U2610126" | Set-ADUser -ipPhone "34666"

Get-ADUser -LDAPFilter '(&(!ipphone=*)(telephoneNumber=*))' -Properties telephoneNumber | 
       ForEach-Object{
            $number =  $_.telephoneNumber
            $number = $number.Split(". ")[-1]
            
            Set-ADUser -Identity $_.SamAccountName -Add @{IpPhone=$number }
      }