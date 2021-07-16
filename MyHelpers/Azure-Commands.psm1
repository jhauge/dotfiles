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
    Imports a bacpac file to a new db, use the parameter azSku to specify db compute setup in azure if necessary

    .Example
    Add-DevIpAddress -ipAddress 111.222.333.444 -ruleNameAppendix cphoffice@addition

    .Parameter sourceFile
    Path to bacpac file to be imported

    .Parameter databaseName
    Database name

    .Parameter serverName
    Server name (must be a network accessible name)

    .Parameter userName
    Server username to use for creating the db

    .Parameter password
    Server password

    .Parameter azSku
    Azure DB SKU possible values: Basic|S0|S1|S2|S4|S3|P1|P2|P4|P6

    .Parameter azMaxSize
    Max size in GB of DB in Azure 
#>
function Import-AzureDb {
    param (
        # Source file   
        [Parameter(Mandatory)]
        [string]
        $sourceFile,

        # Database name
        [Parameter(Mandatory)]
        [string]
        $databaseName,

        # Server name
        [Parameter(Mandatory)]
        [string]
        $serverName,

        # Server user
        [Parameter(Mandatory)]
        [string]
        $userName,

        # server password
        [Parameter(Mandatory)]
        [string]
        $password,

        # SKU Basic|Sx|Px
        [Parameter()]
        [ValidateSet('Basic', 'S0', 'S1', 'S2', 'S3', 'S4', 'P1', 'P2', 'P4', 'P6')]
        [string]
        $azSKU = 'None',

        # Max size of database in Azure
        [Parameter()]
        [Int16]
        $azMaxSize = 2
    )

    $skuType = $azSKU.Substring(0, 1)
    switch ($skuType) {
        'B' { $edition = 'Basic' }
        'S' { $edition = 'Standard' }
        'P' { $edition = 'Premium' }
    }

    # $props = "/p:DatabaseEdition=$edition /p:DatabaseServiceObjective=$sku /p:DatabaseMaximumSize=$maxSize"
    # $connStr = "server=$serverName;database=$databaseName;user id=$userName;password=$password"

    Write-Host "Running import job" -ForegroundColor Green
    & sqlpackage.exe /a:Import /sf:"$sourceFile" /tdn:"$databaseName" /tsn:"$serverName" /tu:"$userName" /tp:"$password" /p:DatabaseEdition="$edition" /p:DatabaseServiceObjective="$azSKU" /p:DatabaseMaximumSize="$azMaxSize"
    
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

