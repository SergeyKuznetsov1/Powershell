Function Get-InstalledApplication
{ 
Param( 
[Parameter(Mandatory=$true)] 
[string[]]$Computername) 

#Registry Hives 

$Object =@() 

$excludeArray = ("Security Update for Windows", 
"Update for Windows", 
"Update for Microsoft .NET", 
"Security Update for Microsoft", 
"Hotfix for Windows", 
"Hotfix for Microsoft .NET Framework", 
"Update for Microsoft OneNote 2010", 
"Hotfix",
"Microsoft Visual C++",
"Update for Microsoft Office 2010",
"Microsoft Office Shared",
"Microsoft Office Proof",
"Update for Microsoft Visio Viewer 2010",
"Service Pack 2 for Microsoft Office 2010",
"Update for Microsoft InfoPath 2010",
"Update for Microsoft Excel 2010",
"Update for Microsoft Outlook 2010",
"Update for Microsoft"
) 

[long]$HIVE_HKROOT = 2147483648 
[long]$HIVE_HKCU = 2147483649 
[long]$HIVE_HKLM = 2147483650 
[long]$HIVE_HKU = 2147483651 
[long]$HIVE_HKCC = 2147483653 
[long]$HIVE_HKDD = 2147483654 

Foreach($EachServer in $Computername){ 
$Query = Get-WmiObject -ComputerName WS261 -query "Select AddressWidth, DataWidth,Architecture from Win32_Processor"  
foreach ($i in $Query) 
{ 
 If($i.AddressWidth -eq 64){             
 $OSArch='64-bit' 
 }             
Else{             
$OSArch='32-bit'             
} 
} 

Switch ($OSArch) 
{ 

 "64-bit"{ 
$RegProv = GWMI -Namespace "root\Default" -list -computername $EachServer| where{$_.Name -eq "StdRegProv"} 
$Hive = $HIVE_HKLM 
$RegKey_64BitApps_64BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 
$RegKey_32BitApps_64BitOS = "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 
$RegKey_32BitApps_32BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 

############################################################################# 

# Get SubKey names 

$SubKeys = $RegProv.EnumKey($HIVE, $RegKey_64BitApps_64BitOS) 

# Make Sure No Error when Reading Registry 

if ($SubKeys.ReturnValue -eq 0) 
{  # Loop Trhough All Returned SubKEys 
ForEach ($Name in $SubKeys.sNames) 
 { 
$SubKey = "$RegKey_64BitApps_64BitOS\$Name" 
$ValueName = "DisplayName" 
$ValuesReturned = $RegProv.GetStringValue($Hive, $SubKey, $ValueName) 
$AppName = $ValuesReturned.sValue 
$Version = ($RegProv.GetStringValue($Hive, $SubKey, "DisplayVersion")).sValue  
$Publisher = ($RegProv.GetStringValue($Hive, $SubKey, "Publisher")).sValue  
$donotwrite = $false 

if($AppName.length -gt "0"){ 

 Foreach($exclude in $excludeArray)  
                        { 
                        if($AppName.StartsWith($exclude) -eq $TRUE) 
                            { 
                            $donotwrite = $true 
                            break 
                            } 
                        } 
            if ($donotwrite -eq $false)  
                        {                         
            $Object += New-Object PSObject -Property @{ 
            Appication = $AppName; 
            #Architecture  = "64-BIT"; 
            #ServerName = $EachServer; 
            #Version = $Version; 
            #Publisher= $Publisher; 
           } 
                        } 

} 

  }} 

############################################################################# 

$SubKeys = $RegProv.EnumKey($HIVE, $RegKey_32BitApps_64BitOS) 

# Make Sure No Error when Reading Registry 

if ($SubKeys.ReturnValue -eq 0) 

{ 

  # Loop Through All Returned SubKEys 

  ForEach ($Name in $SubKeys.sNames) 

  { 

    $SubKey = "$RegKey_32BitApps_64BitOS\$Name" 

$ValueName = "DisplayName" 
$ValuesReturned = $RegProv.GetStringValue($Hive, $SubKey, $ValueName) 
$AppName = $ValuesReturned.sValue 
$Version = ($RegProv.GetStringValue($Hive, $SubKey, "DisplayVersion")).sValue  
$Publisher = ($RegProv.GetStringValue($Hive, $SubKey, "Publisher")).sValue  
 $donotwrite = $false 

if($AppName.length -gt "0"){ 
 Foreach($exclude in $excludeArray)  
                        { 
                        if($AppName.StartsWith($exclude) -eq $TRUE) 
                            { 
                            $donotwrite = $true 
                            break 
                            } 
                        } 
            if ($donotwrite -eq $false)  
                        {                         
            $Object += New-Object PSObject -Property @{ 
            Appication = $AppName; 
            #Architecture  = "32-BIT"; 
            #ServerName = $EachServer; 
            #Version = $Version; 
            #Publisher= $Publisher; 
           } 
                        } 
           } 

    } 

} 

} #End of 64 Bit 

###################################################################################### 

########################################################################################### 

"32-bit"{ 

$RegProv = GWMI -Namespace "root\Default" -list -computername $EachServer| where{$_.Name -eq "StdRegProv"} 

$Hive = $HIVE_HKLM 

$RegKey_32BitApps_32BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 

############################################################################# 

# Get SubKey names 

$SubKeys = $RegProv.EnumKey($HIVE, $RegKey_32BitApps_32BitOS) 

# Make Sure No Error when Reading Registry 

if ($SubKeys.ReturnValue -eq 0) 

{  # Loop Through All Returned SubKEys 

  ForEach ($Name in $SubKeys.sNames) 

  { 
$SubKey = "$RegKey_32BitApps_32BitOS\$Name" 
$ValueName = "DisplayName" 
$ValuesReturned = $RegProv.GetStringValue($Hive, $SubKey, $ValueName) 
$AppName = $ValuesReturned.sValue 
$Version = ($RegProv.GetStringValue($Hive, $SubKey, "DisplayVersion")).sValue  
$Publisher = ($RegProv.GetStringValue($Hive, $SubKey, "Publisher")).sValue  

if($AppName.length -gt "0"){ 

$Object += New-Object PSObject -Property @{ 
            Appication = $AppName; 
            #Architecture  = "32-BIT"; 
            #ServerName = $EachServer; 
            #Version = $Version; 
            #Publisher= $Publisher; 
           } 
           } 

  }} 

}#End of 32 bit 

} # End of Switch 

} 

#$AppsReport 

#$column1 = @{expression="ServerName"; width=15; label="Name"; alignment="left"} 
#$column2 = @{expression="Architecture"; width=10; label="32/64 Bit"; alignment="left"} 
$column3 = @{expression="Appication"; width=80;alignment="left"} 
#$column4 = @{expression="Version"; width=15; label="Version"; alignment="left"} 
#$column5 = @{expression="Publisher"; width=30; label="Publisher"; alignment="left"} 

"#"*80 
"Installed Software Application Report" 
"Numner of Installed Application count : $($object.count)" 
"Generated $(get-date)" 
"Generated from $(gc env:computername)" 
"#"*80 

$object |Format-Table $column3 
#$object|Out-GridView  

$path = 'D:\1.csv' 
$object| Out-File $path -Append
}
