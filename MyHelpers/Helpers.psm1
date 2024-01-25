<#
    .Synopsis
    Show console colors
#>
function Show-Colors {
    $colors = [Enum]::GetValues( [ConsoleColor] )
    $max = ($colors | foreach { "$_ ".Length } | Measure-Object -Maximum).Maximum
    foreach ( $color in $colors ) {
        Write-Host (" {0,2} {1,$max} " -f [int]$color, $color) -NoNewline
        Write-Host "$color" -Foreground $color
    }
}

<#
    .Synopsis
    Get a GUID
#>
function Get-Guid {
    return [guid]::NewGuid()
}
Set-Alias guid global:Get-Guid

<#
    .Synopsis
    Get external IP-address
#>
function Get-MyIpAddress {
    param (
        [switch]$Renew
    )
    if (($myIp -eq $null) -or ($renew)) {
        Write-Host "Getting ip address"
        $Global:myIp = Invoke-RestMethod http://ipinfo.io/json | Select-Object -exp ip
    }
    Write-Host $myIp
}
Set-Alias myip global:Get-MyIpAddress

<# 
    .Synopsis
    Invoke profile scripts
#>
function Invoke-Profile {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | ForEach-Object {
        if(Test-Path $_){
            Write-Verbose "Running $_"
            . $_
        }
    }
}

Export-ModuleMember -Function * -Alias *