
#load SQL snap-in
# Add-PSSnapin *SQL*
#Import-Module "sqlps"

#pull the current date
$date = Get-Date -Format dddd

#set location of backup files

$directory = "C:\SQLServerBackup\Auto\Daily\"

#Grab the database names
$dbname = dir D:\backup | Select Name
#$dbname[0]
#$dbname[1]
#$dbname[2]

foreach ($element in $dbname){ 
   If ( $element -eq "TopoNomenklature" )
    { Continue }
   Else {
      $tmp=@($Element) 
      }
                  }

$tmp



#foreach { $dbname in $dbname } | {    if ( $dbname[0] -eq "TopoNomenklature" ) then $dbname1 = $dbname}


#Backup each user database found.
###$dbname | foreach { $_.Name.ToString() } | foreach {$bakfile = "$directory" + $_ + "_" + $date + ".bak";
###"Backing up Database: $_"; Invoke-Sqlcmd -SuppressProviderContextWarning -Query "BACKUP DATABASE $_ TO DISK='$bakfile' WITH INIT";
###   }