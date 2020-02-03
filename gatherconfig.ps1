. .\paths.ps1;

# Windows terminal
Copy-Item $wintermSettingsPath .\ConfigFiles\;

# VS Code user settings
Copy-Item $vscodeSettingsPath .\ConfigFiles\;

# Git config
Copy-Item $gitconfigPath .\ConfigFiles\;

# pwsh.exe profile
Copy-Item $pwshProfilePath .\ConfigFiles\;
