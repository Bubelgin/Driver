$AzureSQLServerName = "sql-neu-gps-application-uk-live"
$Cred = Get-AutomationPSCredential -Name "CR-NEU-GPS-MAINT-UK-LIVE"
$AzureSQLServerName = $AzureSQLServerName + ".database.windows.net"

Write-Output "---------------------------------------------------------------"
$AzureSQLDatabaseName = "db-neu-gps-realtime-uk-live"
Write-Output "Index and Stats Maintenance for DB " $AzureSQLDatabaseName
Write-Output "---------------------------------------------------------------"
$SQLOutput = $(Invoke-Sqlcmd -ServerInstance $AzureSQLServerName -Username $Cred.UserName -Password $Cred.GetNetworkCredential().Password -Database $AzureSQLDatabaseName -Query "exec [dbo].[AzureSQLMaintenance] @Operation='statistics' ,@LogToTable=1" -QueryTimeout 65535 -ConnectionTimeout 60 -Verbose) 4>&1 
Write-Output $SQLOutput