# My helpers
Push-Location ~\MyHelpers
Import-Module .\MyHelpers.psd1
Pop-Location

# Z directory browsing
Import-Module z

# posh-git
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme jhauge

# Some shortcuts
Set-Alias -Name Select-AzContext -Value azcontext

$env:path += ";C:\Program Files\Microsoft SQL Server\140\DAC\bin;C:\Program Files\Git\usr\bin\;C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\;~\AppData\Local\gmaster\bin\"
