$AzureSQLServerName = "sql-neu-gps-upload-uk-qa"
$Cred = Get-AutomationPSCredential -Name "CR-NEU-GPS-MAINT-UK-QA"
$AzureSQLServerName = $AzureSQLServerName + ".database.windows.net"

Write-Output "---------------------------------------------------------------"
$AzureSQLDatabaseName = "db-neu-gps-upload-uk-qa"
Write-Output "Index  Maintenance for DB " $AzureSQLDatabaseName
Write-Output "---------------------------------------------------------------"
$SQLOutput = $(Invoke-Sqlcmd -ServerInstance $AzureSQLServerName -Username $Cred.UserName -Password $Cred.GetNetworkCredential().Password -Database $AzureSQLDatabaseName -Query "exec [dbo].[AzureSQLMaintenance] @Operation='Index' ,@LogToTable=1" -QueryTimeout 65535 -ConnectionTimeout 60 -Verbose) 4>&1 
Write-Output $SQLOutput