
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


Foreach             
where {$name -eq 'running' }) 