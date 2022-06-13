function MKDIR_AND_COPY {  
$Computers = Get-Content C:\temp\Computers.txt -ReadCount 0
$ErrorActionPreference = 'Stop'    
ForEach ($computer in $computers) {   
 Try   
    {  
  
  New-item -itemtype directory -path \\$computer\C$\Temp\2012R2
  
  Copy-Item C:\temp\2012R2\*  \\$computer\C$\temp\2012R2\

  Invoke-Command -ComputerName $computer -ScriptBlock {start-process 'C:\Temp\2012R2\InstallMSU_2012R2.ps1' -Wait}
  
    }  
 Catch   
     {  
  Add-content $computer -path "$env:USERPROFILE\Desktop\failed_list.txt" 
     }   
                          }  
                        }  
MKDIR_AND_COPY | Out-File "$env:USERPROFILE\Desktop\Done_list.txt"
Write-Host "Operation Completed" -ForegroundColor Green
Write-host "Check your Desktop for output Files" -ForegroundColor Green
