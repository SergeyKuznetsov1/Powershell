$outFile = "D:\Check\$env:computername.txt"
$userToFind = $env:username
$administratorsAccount = Get-WmiObject Win32_Group -filter "LocalAccount=True AND SID='S-1-5-32-544'"
$administratorQuery = "GroupComponent = `"Win32_Group.Domain='" + $administratorsAccount.Domain + "',NAME='" + $administratorsAccount.Name + "'`""
$user = Get-WmiObject Win32_GroupUser -filter $administratorQuery | select PartComponent |where {$_ -match $userToFind}
$user=$user.PartComponent.Split("\,")[5].Remove(0,5).Replace('"','')
if ($user -eq $userToFind) 
             {Write-Host "Warning: $user is Administrator"}  Out-File $outFile