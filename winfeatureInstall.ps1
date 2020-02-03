# IIS setup
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-WebServerRole
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-CommonHttpFeatures
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-HttpErrors
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-NetFxExtensibility45
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-HealthAndDiagnostics
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-HttpLogging
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-HttpTracing
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-Security
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-RequestFiltering
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-Performance
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-HttpCompressionDynamic
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-WebServerManagementTools
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-HostableWebCore
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-StaticContent
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-DefaultDocument
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-ASPNET45
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-HttpCompressionStatic
Enable-WindowsOptionalFeature -All -Online -FeatureName IIS-ManagementConsole

# .NET setup
Enable-WindowsOptionalFeature -All -Online -FeatureName NetFx4-AdvSrvs
Enable-WindowsOptionalFeature -All -Online -FeatureName NetFx4Extended-ASPNET45
Enable-WindowsOptionalFeature -All -Online -FeatureName NetFx3
Enable-WindowsOptionalFeature -All -Online -FeatureName Microsoft-Windows-NetFx3-OC-Package
Enable-WindowsOptionalFeature -All -Online -FeatureName Microsoft-Windows-NetFx4-US-OC-Package

# WSL Setup
Enable-WindowsOptionalFeature -All -Online -FeatureName VirtualMachinePlatform
Enable-WindowsOptionalFeature -All -Online -FeatureName Microsoft-Windows-Subsystem-Linux
