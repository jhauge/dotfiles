<#
    .Synopsis
    Backup Azure DB

    .Parameter databaseName
    Name of database to backup

    .Parameter serverName
    Server name where database is located

    .Parameter userName
    User name for server/db access

    .Parameter password
    Password for server/db access

    .Parameter backupDirectory
    Path to directory to put bacpak file in
#>
function Backup-AzureDB {
    param($databaseName = '', $serverName = '', $userName = '', $password = '', $backupDirectory = '')
    # Location of Microsoft.SqlServer.Dac.dll
    $DacAssembly = "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\Extensions\Application\Microsoft.SqlServer.Dac.dll"

    $connectionString = "server=$serverName;database=$databaseName;user id=$userName;password=$password"

    # Load DAC assembly
    Write-Host "Loading Dac Assembly: $DacAssembly"
    Add-Type -Path $DacAssembly
    Write-Host "Dac Assembly loaded."

    # Initialize Dac
    $now = $(Get-Date).ToString("HH:mm:ss")
    $services = new-object Microsoft.SqlServer.Dac.DacServices $connectionString
    if ($null -eq $services) {
        exit
    }

    $dateTime = $(Get-Date).ToString("yyyy-MM-dd-HH.mm.ss")

    Write-Host "Starting backup of $databaseName at $now"
    $watch = New-Object System.Diagnostics.StopWatch
    $watch.Start()
    $services.ExportBacpac("$backupDirectory$databaseName-$dateTime.bacpac", $databaseName)
    $watch.Stop()
    Write-Host "Backup completed in" $watch.Elapsed.ToString()
}

<#
    .Synopsis
    Gets name of current AzContext and creates variable that will show on prompt

    .Exampe
    Show-AzContext
#>
function Show-AzContext {
    $global:currentAzContext = Get-AzContext | Select-Object Name
    Write-Output $currentAzContext
}

Export-ModuleMember -Function *

