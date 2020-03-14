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

Export-ModuleMember -Function * -Alias *