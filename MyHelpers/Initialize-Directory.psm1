<#
    .Synopsis
    Creates a directory and changes into it

    .Example
    Initialize-Directory .\NewDir\NewNewDir

    .Parameter path
    Path to directory
#>
function Initialize-Directory {
    param(
        $path = '.\newdir'
    )
    if (-not(Test-Path $path)) {
        mkdir $path; 
    }
    Set-Location $path
}

Set-Alias -Name mcd -Value Initialize-Directory
Export-ModuleMember -Function Initialize-Directory -Alias mcd