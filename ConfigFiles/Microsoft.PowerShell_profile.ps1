# Get my current external ip
$Global:myIp = Invoke-RestMethod http://ipinfo.io/json | Select-Object -exp ip

# My helpers
Push-Location ~\MyHelpers
Import-Module .\MyHelpers.psd1
Pop-Location

# Z directory browsing
Import-Module z

# New windows terminal
Import-Module MSTerminalSettings

# posh-git
Import-Module posh-git

# Azure Powershell
Import-Module Az

# posh-git colors
$GitPromptSettings.DefaultColor.ForegroundColor = [ConsoleColor]::White
$GitPromptSettings.DefaultColor.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.PathStatusSeparator.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.BeforeStatus.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.BranchColor.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.IndexColor.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.WorkingColor.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.StashColor.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.DelimStatus.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.AfterStatus.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.BeforeIndex.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.BeforeStash.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.AfterStash.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.LocalDefaultStatusSymbol.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.LocalWorkingStatusSymbol.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.BranchAheadStatusSymbol.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.BranchAheadStatusSymbol.ForegroundColor = [ConsoleColor]::DarkGreen
$GitPromptSettings.BranchBehindStatusSymbol.BackgroundColor = [ConsoleColor]::DarkGray
$GitPromptSettings.BranchBehindStatusSymbol.ForegroundColor = [ConsoleColor]::DarkRed
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.BackgroundColor = [ConsoleColor]::DarkGray

$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BeforeStatus.Text = " "
$GitPromptSettings.AfterStatus.Text = " "

#"C:\Program Files\Microsoft SQL Server\140\DAC\bin\SqlPackage.exe"

$env:path += ";C:\Program Files\Microsoft SQL Server\140\DAC\bin;C:\Program Files\Git\usr\bin\;C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\;C:\Users\jespe\AppData\Local\gmaster\bin\"

$loadedModules = Get-Module | Select-Object Name


Set-Content Function:prompt {
    Write-Host ""

    # Write any custom prompt environment (f.e., from vs2017.ps1)
    if (get-content variable:\PromptEnvironment -ErrorAction Ignore) {
        Write-Host " " -NoNewLine
        Write-Host $PromptEnvironment -NoNewLine -BackgroundColor DarkMagenta -ForegroundColor White
    }

    # Write ERR for any PowerShell errors
    if ($Error.Count -ne 0) {
        Write-Host "🤢 " -NoNewLine
        $Error.Clear()
    }
    else {
        Write-Host "😊 " -NoNewLine
    }

    # Write the current public cloud Azure CLI subscription
    # NOTE: You will need sed from somewhere (for example, from Git for Windows)
    # if (Test-Path ~/.azure/clouds.config) {
    #     $currentSub = & sed -nr "/^\[AzureCloud\]/ { :l /^subscription[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ~/.azure/clouds.config
    #     if ($null -ne $currentSub) {
    #         $currentAccount = (Get-Content ~/.azure/azureProfile.json | ConvertFrom-Json).subscriptions | Where-Object { $_.id -eq $currentSub }
    #         if ($null -ne $currentAccount) {
    #             Write-Host " " -NoNewLine
    #             Write-Host " ∞" -NoNewLine -BackgroundColor DarkGray -ForegroundColor White
    #             Write-Host " $($currentAccount.name) " -NoNewLine -BackgroundColor DarkGray -ForegroundColor White
    #         }
    #     }
    # }

    # Write the current Azure Powershell context if any
    if (($loadedModules -like "*Az.Account*") -and ($null -ne $currentAzContext)) {
        Write-Host " " -NoNewLine
        Write-Host " ∞" -NoNewLine -BackgroundColor DarkGray -ForegroundColor White
        Write-Host " $($currentAzContext.Name) " -NoNewLine -BackgroundColor DarkGray -ForegroundColor White
    }

    # Write the current Git information
    if (Get-GitDirectory -ne $null) {
        Write-Host " " -NoNewline
        Write-Host (Write-VcsStatus) -NoNewLine
    }

    # Write the current directory, with home folder normalized to ~
    $currentPath = (get-location).Path.replace($home, "~")
    $idx = $currentPath.IndexOf("::")
    if ($idx -gt -1) { $currentPath = $currentPath.Substring($idx + 2) }
 
    Write-Host " " -NoNewLine
    Write-Host "" -NoNewLine -BackgroundColor DarkGray -ForegroundColor White
    Write-Host " $currentPath " -NoNewLine -BackgroundColor DarkGray -ForegroundColor White

    Write-Host ""

    $isAdmin = $false
    $isDesktop = ($PSVersionTable.PSEdition -eq "Desktop")
 
    if ($isDesktop -or $IsWindows) {
        $windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
        $isAdmin = $windowsPrincipal.IsInRole("Administrators") -eq 1
    }
    else {
        $isAdmin = ((& id -u) -eq 0)
    }
 
    if ($isAdmin) { $color = "Red"; }
    else { $color = "Green"; }
 
    # Write PS> for desktop PowerShell, pwsh> for PowerShell Core
    if ($isDesktop) {
        Write-Host "PS>" -NoNewLine -ForegroundColor $color
    }
    else {
        Write-Host "pwsh>" -NoNewLine -ForegroundColor $color
    }
 
    # Always have to return something or else we get the default prompt
    return " "
}

