# Install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; `
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));

# Install git to download rest of setup
choco install -Y git.install
choco install -Y git-credential-manager-for-windows

# Install scripts
. .\winfeatureInstall.ps1
. .\swInstall.ps1
. .\psmoduleInstall.ps1
. .\vscodeInstall.ps1
