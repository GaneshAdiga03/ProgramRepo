function MKDIR_AND_COPY {  
$Computers = Get-Content C:\temp\Computers.txt -ReadCount 0
$ErrorActionPreference = 'Stop'    
ForEach ($computer in $computers) {   
 Try   
    {  
  
  New-item -itemtype directory -path \\$computer\C$\Temp\SCOMandDependencyagent
  
  Copy-Item C:\temp\SCOMandDependencyagent\*  \\$computer\C$\temp\SCOMandDependencyagent\

  Invoke-Command -ComputerName $computer -ScriptBlock {start-process 'C:\Temp\SCOMandDependencyagent\InstallDependencyAgent-Windows.exe' /S -Wait}
  
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
