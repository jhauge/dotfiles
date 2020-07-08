. .\paths.ps1;

# Windows terminal
Copy-Item $wintermSettingsPath .\ConfigFiles\winterm\settings.json;

# VS Code user settings
Copy-Item $vscodeSettingsPath .\ConfigFiles\vscode\settings.json;

# Git config
Copy-Item $gitconfigPath .\ConfigFiles\;

# pwsh.exe profile
Copy-Item $pwshProfilePath .\ConfigFiles\;

# oh-my-posh profile
Copy-Item $ohmyposhProfilePath .\ConfigFiles\;
