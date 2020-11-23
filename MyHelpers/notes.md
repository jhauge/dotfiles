# Notes

## Add Tags

``` powershell
$tags = @{ApplicationOwner="at@sct.dk"; ApplicationContact="jhu@novicell.dk"} # Create tagset
$tags = $tags (Get-AzResource -ResourceGroupName 'rgname' -Name 'resourcename' # Get tagset from resource

# Set tags on resource
$resource = Get-AzResource -ResourceGroupName $rgName -Name 'resourcename' # Get resource object
Set-AzResource -ResourceId $resource.Id -Tag $tags -Force # set tags on resource
```

## Create webapp with app service plan

``` powershell
[CmdletBinding()]
param (
    # Resource group name
    [Parameter()]
    [string]
    $rgName,
    # App ServicePlan tier Basic|Standard|Premium
    [Parameter()]
    [string]
    $appsvcTier,
    # Size of App ServicePlan worker Small|Medium|Large
    [Parameter()]
    [string]
    $appsvcWorkersSize,
    # Environment name dev|qa|prod
    [Parameter()]
    [string]
    $environmentName
)

$appsvcName = "plan-customerportal-$($environmentName)shared-001"

New-AzAppServicePlan -Location 'West Europe' `
    -Name "$appsvcName" `
    -ResourceGroupName "$rgName" `
    -Tier "$appsvcTier" `
    -NumberofWorkers 1 `
    -WorkerSize "$appsvcWorkersSize"

New-AzWebApp -Location 'West Europe' `
    -ResourceGroupName "$rgName" `
    -Name "app-identityserver-$environmentName-001" `
    -AppServicePlan "$appsvcName" `

New-AzWebApp -Location 'West Europe' `
    -ResourceGroupName "$rgName" `
    -Name "app-customerportal-$environmentName-001" `
    -AppServicePlan "$appsvcName"

Set-AzWebApp -Name 'app-identityserver-$environmentName-001' `
    -NetFrameworkVersion 
```
