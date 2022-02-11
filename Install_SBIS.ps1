
#######
# Get ProductCode from MSI file
#######
function Get-ProductCode ($pathMSI) {
    $comObjWI = New-Object -ComObject WindowsInstaller.Installer
    $MSIDatabase = $comObjWI.GetType().InvokeMember("OpenDatabase","InvokeMethod",$Null,$comObjWI,@($pathMSI,0))
    $Query = "SELECT Value FROM Property WHERE Property = 'ProductCode'"
    $View = $MSIDatabase.GetType().InvokeMember("OpenView","InvokeMethod",$null,$MSIDatabase,($Query))
    $View.GetType().InvokeMember("Execute", "InvokeMethod", $null, $View, $null)
    $Record = $View.GetType().InvokeMember("Fetch","InvokeMethod",$null,$View,$null)
    $Value = $Record.GetType().InvokeMember("StringData","GetProperty",$null,$Record,1)
    
    Return $Value
}


######
# Function to check if program with specified ProductCode already installed
######
function Check-Install($productCode) {
    $registryPath32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$productCode"
    $registryPath64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$productCode"
    #$OS64bit = [Environment]::Is64BitOperatingSystem
    $OS64bit = (Get-WmiObject  Win32_OperatingSystem).OSArchitecture
    #Write-Host $registryPath
    if ($OS64bit -like "64*") {
        $installed = Test-Path -Path $registryPath64
    } else {
         $installed = Test-Path -Path $registryPath32
    }
    Return  $installed
}

######
# Unstall MSI package
######
function Install-MSI ($pathMSI,$logFile) {
        
    &msiexec  /i $pathMSI   /qn TRANSFORMS="adminstallrelogon.mst;1049.mst" DESIGNERALLCLIENTS=1 THICKCLIENT=1 THINCLIENTFILE=1 THINCLIENT=1 WEBSERVEREXT=0 SERVER=0 CONFREPOSSERVER=0 CONVERTER77=0 SERVERCLIENT=0 LANGUAGES=RU /L*V+ $logFile | Out-Null
}




$targetVersion = "8.3.16.1814"      #change to your value
$distribPath = "\\M-FS01-R1\1C_install$\1C_Client"           #change to your value
$logPath = "\\M-FS01-R1\1C_install$\1C_Log"          #change to your value

$pathMSI = "$distribPath\$targetVersion\1CEnterprise 8.msi"
$hostname = hostname
$logFile = "$logPath\$hostname.log"
$datetime = Get-Date -Format "dd.MM.yyyy HH:mm:ss"

$productCode = Get-ProductCode $pathMSI
$productCode = $productCode[1]
#Write-host $productCode | fl
$installed = Check-Install $productCode

if ($installed) {
    "$datetime     1C:Предприятие $targetVersion ($productCode) already installed" | Out-File -FilePath "$logFile" -Append
    } else {
        "$datetime     Installing 1С:Предприятие $targetVersion ($productCode) ...." | Out-File -FilePath "$logFile" -Append
        Install-MSI $pathMSI $logFile
        $datetime_end = Get-Date -Format “dd.MM.yyyy HH:mm:ss”
        "$datetime_end     Installation of 1С:Предприятие $targetVersion ($productCode) completed" | Out-File -FilePath "$logFile" -Append
    }

