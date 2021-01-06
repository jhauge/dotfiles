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

<# 
    .Synopsis
    Adds an allow rule for provided IP-address to Azure SQL Server

    .Example
    Add-DevIpAddress -ipAddress 111.222.333.444 -ruleNameAppendix cphoffice@addition

    .Parameter ipAddress
    The ip address to allow through firewall to sql server

    .Parameter ruleNameAppendix
    Added to rule name after "allow-" use a name that descripes the person(s) you're allowing like cphoffice@addition for all at Addition office or jes@addition for single person ip.

#>
function Add-AzSqlServerIpAllowRule {
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $ipAddress,
        [Parameter(Mandatory = $true)]
        [string]
        $ruleNameAppendix,
        [Parameter(Mandatory = $true)]
        [string]
        $sqlServerName,
        [Parameter(Mandatory = $true)]
        [string]
        $rgName
    )

    Write-Host "Adding rule named allow-$ruleNameAppendix for ip $ipAddress to $sqlServerName"
    New-AzSqlServerFirewallRule -FirewallRuleName "allow-$ruleNameAppendix" `
        -StartIpAddress $ipAddress `
        -EndIpAddress $ipAddress `
        -ResourceGroupName $rgName `
        -ServerName $sqlServerName

    Write-Host "Rule allow-$ruleNameAppendix added to $sqlServerName" -ForegroundColor Green
}

Export-ModuleMember -Function *

