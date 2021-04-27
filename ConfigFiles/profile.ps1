# My helpers
Push-Location ~\MyHelpers
Import-Module .\MyHelpers.psd1
Pop-Location

# Folder icons
Import-Module -Name Terminal-Icons

# Z directory browsing
Import-Module z

# posh-git
Import-Module oh-my-posh
Set-PoshPrompt ~\.ohmyposh.jhauge.json

# Aliases
Set-Alias -Name selcontext -Value Select-AzContext
