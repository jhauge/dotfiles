# chocolatey software
if (-not($env:ChocolateyInstall)) {
    Write-Host "Install chocolatey before use" -ForegroundColor Red
    exit
}

# Dev setup
choco install -Y microsoft-windows-terminal
choco install -Y vscode.install
choco install -Y visualstudio2019professional
choco install -Y netfx-4.8-devpack
choco install -Y dotnetcore-sdk
choco install -Y visualstudio2019-workload-azure # VS workload for Azure
choco install -Y visualstudio2019-workload-netweb # VS workload for Web
choco install -Y visualstudio2019-workload-netcoretools # VS workload for .net core
choco install -Y microsoftazurestorageexplorer
choco install -Y azure-data-studio
choco install -Y nvm
choco install -Y postman
choco install -Y wsl-ubuntu-1804
choco install -Y vcredist140 # used in node to compile node-sass

# Other tools
choco install -Y 7zip.install
choco install -Y dashlane
choco install -Y FiraCode
choco install -Y googlechrome
choco install -Y Firefox
choco install -Y spotify
