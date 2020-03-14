<#
    .Synopsis
    Open hosts file in Admin notepad
#>
function Edit-Hosts {
    start-process -verb runAs "notepad" -argumentlist "C:\Windows\System32\drivers\etc\hosts"
}

Set-Alias -Name eh -Value Edit-Hosts
Export-ModuleMember -Function Edit-Hosts -Alias eh

