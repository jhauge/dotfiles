# Create and enter directory
function global:CreateAndChangeTo-Directory () {
    md $args[0]; cd $args[0]
}
Set-Alias mcd CreateAndChangeTo-Directory

# Edit hosts file
function global:Edit-Hosts () {
    start-process -verb runAs "notepad" -argumentlist "C:\Windows\System32\drivers\etc\hosts"
}
Set-Alias eh Edit-Hosts

# Git shortcut to add all and commit
function global:Git-Commit {
    param($message)
    git add .
    git commit -m "$message"
}
Set-Alias gcom Git-Commit

# Git shortcut to create branch locally and push to shared repo
function global:Git-Branch {
    param($branchName,$message)
    git checkout -b "$branchName"
    git add .
    git commit -m "$message"
    git push -u origin "$branchName"
}
Set-Alias gbranch Git-Branch

# Git remove branch locally and in shared repo
function global:Git-RemoveBranch {
  param($branchName,$remoteName='origin')
  git branch -d "$branchName"
  git push $remoteName --delete "$branchName"
}
Set-Alias gremove Git-RemoveBranch

# Open Gmaster in path
function global:Open-GMaster {
    param($path='.')
    & gmaster --path="$path"
}
Set-Alias gmas Open-GMaster

# Create file in utf-8 with content
function global:Create-File {
    param($content='Empty file', $filename='newfile.txt', $currentPath='.')
    $encoding = New-Object System.Text.UTF8Encoding $false
    $path = Convert-Path $currentPath
    $fullname = "$path/$filename"
    [System.IO.File]::WriteAllText($fullname, $content, $encoding)
}
Set-Alias wf Create-File

# Show console colors
function global:Show-Colors( ) {
    $colors = [Enum]::GetValues( [ConsoleColor] )
    $max = ($colors | foreach { "$_ ".Length } | Measure-Object -Maximum).Maximum
    foreach( $color in $colors ) {
        Write-Host (" {0,2} {1,$max} " -f [int]$color,$color) -NoNewline
        Write-Host "$color" -Foreground $color
    }
}

function global:Get-Guid() {
    return [guid]::NewGuid()
}
Set-Alias guid global:Get-Guid

# Z directory browsing
Import-Module z

# New windows terminal
Import-Module MSTerminalSettings

# posh-git
Import-Module posh-git

# Azure Powershell
Import-Module Az

# posh-git colors
$GitPromptSettings.DefaultColor.ForegroundColor=[ConsoleColor]::White
$GitPromptSettings.DefaultColor.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.PathStatusSeparator.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.BeforeStatus.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.BranchColor.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.IndexColor.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.WorkingColor.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.StashColor.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.DelimStatus.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.AfterStatus.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.BeforeIndex.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.BeforeStash.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.AfterStash.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.LocalDefaultStatusSymbol.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.LocalWorkingStatusSymbol.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.BranchAheadStatusSymbol.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.BranchAheadStatusSymbol.ForegroundColor=[ConsoleColor]::DarkGreen
$GitPromptSettings.BranchBehindStatusSymbol.BackgroundColor=[ConsoleColor]::DarkGray
$GitPromptSettings.BranchBehindStatusSymbol.ForegroundColor=[ConsoleColor]::DarkRed
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.BackgroundColor=[ConsoleColor]::DarkGray

$GitPromptSettings.BeforeStatus.ForegroundColor=[ConsoleColor]::DarkBlue
$GitPromptSettings.BeforeStatus.Text=" "
$GitPromptSettings.AfterStatus.Text=" "

$env:path += ";C:\Program Files\Microsoft SQL Server\130\DAC\bin;C:\Windows\Microsoft.NET\Framework64\v4.0.30319;C:\Users\Jesper\AppData\Local\gmaster\bin\;C:\Program Files\Git\usr\bin\;C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\;C:\Users\jespe\AppData\Local\gmaster\bin\"


Set-Content Function:prompt {
    Write-Host ""

    # Write any custom prompt environment (f.e., from vs2017.ps1)
    if (get-content variable:\PromptEnvironment -ErrorAction Ignore) {
        Write-Host " " -NoNewLine
        Write-Host $PromptEnvironment -NoNewLine -BackgroundColor DarkMagenta -ForegroundColor White
    }

    # Write ERR for any PowerShell errors
    if ($Error.Count -ne 0) {
        Write-Host "😫 " -NoNewLine
        $Error.Clear()
    }
    else {
        Write-Host "😊 " -NoNewLine
    }

    # Write the current public cloud Azure CLI subscription
    # NOTE: You will need sed from somewhere (for example, from Git for Windows)
    if (Test-Path ~/.azure/clouds.config) {
        $currentSub = & sed -nr "/^\[AzureCloud\]/ { :l /^subscription[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ~/.azure/clouds.config
        if ($null -ne $currentSub) {
            $currentAccount = (Get-Content ~/.azure/azureProfile.json | ConvertFrom-Json).subscriptions | Where-Object { $_.id -eq $currentSub }
            if ($null -ne $currentAccount) {
                Write-Host " " -NoNewLine
                Write-Host " ∞" -NoNewLine -BackgroundColor DarkGray -ForegroundColor White
                Write-Host " $($currentAccount.name) " -NoNewLine -BackgroundColor DarkGray -ForegroundColor White
            }
        }
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
     } else {
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
