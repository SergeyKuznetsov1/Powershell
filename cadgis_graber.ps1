# Проверяем если есть файл удалить
#$filename = $env:COMPUTERNAME
$filename = $env:COMPUTERNAME+'_'+$env:UserName

$path = '\\fserver\Resources\Logs\Установленное ПО\CadGIS\'+ $filename + '.csv' 
$isfile = Test-Path $path 
if($isfile -eq "True") {
	#Если Файл существует ...
	Remove-Item -Path $path
	#... удалить файл.
}
   
$Object =@() 

#Исключение обновлений

$excludeArray = ("AutoCAD",
 "TrueView",
 "Revit",
 "Civil",
 "MapInfo",
 "Inventor"


) 

[long]$HIVE_HKROOT = 2147483648 
[long]$HIVE_HKCU = 2147483649 
[long]$HIVE_HKLM = 2147483650 
[long]$HIVE_HKU = 2147483651 
[long]$HIVE_HKCC = 2147483653 
[long]$HIVE_HKDD = 2147483654 

	## Определяем разрядность ОС
$Query = Get-WmiObject -ComputerName $env:COMPUTERNAME -query "Select AddressWidth, DataWidth,Architecture from Win32_Processor"  
foreach ($i in $Query) 
{ 
 If($i.AddressWidth -eq 64){             
 #Если разрядность 64 бита
 $OSArch='64-bit'
 }             
Else{             
#Если разрядность 32 бита
$OSArch='32-bit'             
} 
} 

Switch ($OSArch) 
{
#Для 64 ОС делаем....
 "64-bit"{ 
$RegProv = GWMI -Namespace "root\Default" -list -computername $env:COMPUTERNAME| where{$_.Name -eq "StdRegProv"} 
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
$write = $false 
#$write = $true 

if($AppName.length -gt "0"){ 

 Foreach($exclude in $excludeArray)  
                        { 
                        if($AppName.Contains($exclude) -eq $true)
                          { 
                            $write = $true
                            break 
                            } 
                        } 
            if ($write -eq $true)  
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
 $write = $false 

if($AppName.length -gt "0"){ 
 Foreach($exclude in $excludeArray)  
                        { 
                        if($AppName.Contains($exclude) -eq $true) 
                            { 
                            $write = $true 
                            break 
                            } 
                        } 
            if ($write -eq $true)  
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




"32-bit"{ 
$RegProv = GWMI -Namespace "root\Default" -list -computername $env:COMPUTERNAME | where{$_.Name -eq "StdRegProv"} 

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

$write = $false
 
if($AppName.length -gt "0"){ 

 Foreach($exclude in $excludeArray)  
                        { 
                        if($AppName.Contains($exclude) -eq $true) 
                            { 
                            $write = $true 
                            break 
                            } 
                        } 
            if ($write -eq $true)  
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
} #End of 32 bit 
 
} # End of Switch 

   
   
#$AppsReport 

#$column1 = @{expression="ServerName"; width=15; label="Name"; alignment="left"} 
#$column2 = @{expression="Architecture"; width=10; label="32/64 Bit"; alignment="left"} 
$column3 = @{expression="Appication"; width=80; alignment="left"}
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

$object| Out-File $path -Append
