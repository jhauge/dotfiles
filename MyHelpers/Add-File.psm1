<#
    .Synopsis
    Adds an UTF8 based text file to current directory

    .Description
    Creates an UTF8 based text file with the given parameter values to the path specified

    .Example
    Add-File -filename 'newfile.txt' -content 'Empty file' -currentPath .

    .Parameter filename
    Name of file to add

    .Parameter content
    Content to be added to file - use a short string and open with an editor to go further

    .Parameter currentPath
    Path to prepend filename - if nothing is specified it will use . which means adding to current location
#>
function Add-File {
    param(
        $filename = 'newfile.txt', 
        $content = 'Empty file', 
        $currentPath = '.'
    )
    $encoding = New-Object System.Text.UTF8Encoding $false
    $path = Convert-Path $currentPath
    $fullname = "$path/$filename"
    [System.IO.File]::WriteAllText($fullname, $content, $encoding)
}

Set-Alias -Name af -Value Add-File
Export-ModuleMember -Function Add-File -Alias af