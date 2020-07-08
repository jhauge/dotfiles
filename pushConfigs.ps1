. .\paths.ps1

# Powershell config
Copy-Item .\ConfigFiles\Microsoft.PowerShell_profile.ps1 $pwshProfilePath -Force;

# oh-my-posh config
Copy-Item .\ConfigFiles\jhauge.psm1 $ohmyposhProfilePath -Force

# Windows terminal
Copy-Item .\ConfigFiles\profiles.json $wintermSettingsPath;

# VS Code user settings
Copy-Item  .\ConfigFiles\settings.json $vscodeSettingsPath;

# Git config
Copy-Item  .\ConfigFiles\.gitconfig $gitconfigPath;

# Helper module
Copy-Item .\MyHelpers\ ~\ -Recurse -Force
