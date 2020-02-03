# chocolatey software
if (-not($env:ChocolateyInstall)) {
    Write-Host "Install chocolatey before use" -ForegroundColor Red
    exit
}

choco install -Y 7zip.install
choco install -Y azure-data-studio
choco install -Y vscode.install
choco install -Y dashlane
choco install -Y FiraCode
choco install -Y googlechrome
choco install -Y Firefox
choco install -Y microsoftazurestorageexplorer
choco install -Y microsoft-windows-terminal
choco install -Y nvm
choco install -Y postman
choco install -Y wsl-ubuntu-1804
choco install -Y visualstudio2019professional
choco install -Y spotify
