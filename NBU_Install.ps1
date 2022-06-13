#Servers path
$ServerName = Get-content -path "C:\Temp\computers.txt"

#Netbackup sourcefile (Sample)
$sourcefile = "C:\Temp\x64\"

#This section will copy and install the software 
foreach ($Computer in $Servername)
{
 
 #This section will copy the $sourcefile to the destination. If the Folder does not exist it will create it.
 New-item -itemtype directory -path \\$computer\C$\Temp\x64\
  
 Copy-Item C:\temp\x64\*  \\$computer\C$\temp\X64\

 # Install NetBackup Client
 Invoke-Command -ComputerName $Computer -ScriptBlock {Set-Location 'C:\Temp\x64'
  & cmd /c ".\silentclient.cmd" -Wait}

    if ($setup.exitcode -eq 0) {
 $result = "The Installation of NetBackup Client 8.2 is Successful" 
 $date = get-date -format g
    }
    else
    {
 $result = "The Installation of NetBackup Client 8.2 is Failed"
 $date = get-date -format g
    } 
write-host $result on $Computer

#Output the install result to the Local C Drive
 Out-File -FilePath C:\users\amgmanjunatha\desktop\NBStatus.txt -Append -InputObject ("ComputerName: $computer Result: $result on $Date")
}
