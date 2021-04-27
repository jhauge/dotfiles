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
    [CmdletBinding(DefaultParameterSetName = 'ConnString')]
    param(
        [Parameter(Position = 0)]
        $backupDirectory = '',

        [Parameter(ParameterSetName = 'ConnVals')]
        $databaseName = '', 
        [Parameter(ParameterSetName = 'ConnVals')]
        $serverName = '', 
        [Parameter(ParameterSetName = 'ConnVals')]
        $userName = '', 
        [Parameter(ParameterSetName = 'ConnVals')]
        $password = '', 

        [Parameter(ParameterSetName = 'ConnString')]
        $dbConnStr = ''
    )

    if ($PSCmdlet.ParameterSetName -eq 'ConnVals') {
        $dbConnStr = "server=$serverName;database=$databaseName;user id=$userName;password=$password"
    }

    if ($PSCmdlet.ParameterSetName -eq 'ConnString') {
        $dbConnStr -match 'Initial Catalog=(.*);Persist'
        $databaseName = $matches[1]
    }

    $dateTime = $(Get-Date).ToString("yyyy-MM-dd-HH.mm.ss")
    $backupFile = "$backupDirectory\$databaseName-$dateTime.bacpac"

    Write-Host "Backing up database $databaseName" -ForegroundColor Green
    & sqlpackage.exe /Action:Export /SourceConnectionString:"$dbConnStr" /TargetFile:"$backupFile"
}

Export-ModuleMember -Function *

