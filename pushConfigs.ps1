. .\paths.ps1

# Powershell config
Copy-Item .\ConfigFiles\profile.ps1 $pwshProfilePath -Force;

# oh-my-posh config
Copy-Item .\ConfigFiles\.ohmyposh.jhauge.json $ohmyposhProfilePath -Force

# Windows terminal
Copy-Item .\ConfigFiles\winterm\settings.json $wintermSettingsPath;

# VS Code user settings
Copy-Item  .\ConfigFiles\vscode\settings.json $vscodeSettingsPath;

# Git config
Copy-Item  .\ConfigFiles\.gitconfig $gitconfigPath;

# Helper module
Copy-Item .\MyHelpers\ ~\ -Recurse -Force
