#load SQL snap-in
# Add-PSSnapin *SQL*
Import-Module "sqlps"

#pull the current date
$date = Get-Date -Format dddd

#set location of backup files
$directory = "C:\SQLServerBackup\Auto\Daily\"

#Grab the database names
$dbname = dir 'SQLSERVER:\SQL\APPSERVER2\DEFAULT\databases' | Select Name
$dbname | foreach 



#Backup each user database found.
$dbname | foreach { $_.Name.ToString() } | foreach {$bakfile = "$directory" + $_ + "_" + $date + ".bak";
"Backing up Database: $_"; Invoke-Sqlcmd -SuppressProviderContextWarning -Query "BACKUP DATABASE $_ TO DISK='$bakfile' WITH INIT";
   }