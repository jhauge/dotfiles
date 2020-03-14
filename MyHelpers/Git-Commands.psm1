<#
    .Synopsis
    Adds all files to git stage and commits with message in message param

    .Parameter message
    The git message to attach
#>
function Invoke-GitCommit {
    param($message)
    git add .
    git commit -m "$message"
}
Set-Alias gcom Invoke-GitCommit

<#
    .Synopsis
    Git shortcut to create branch locally and push to shared repo

    .Parameter branchName
    Name of branch to create

    .Parameter message
    Message for accompanying git commit
#>
function New-GitBranch {
    param($branchName, $message)
    git checkout -b "$branchName"
    git add .
    git commit -m "$message"
    git push -u origin "$branchName"
}
Set-Alias gbranch New-GitBranch

<#
    .Synopsis
    Git remove branch locally and in shared repo

    .Parameter branchName
    Name of branch to remove

    .Parameter remoteName
    Remote to remove branch in - defaults to 'origin'
#>
function Remove-GitBranch {
    param($branchName, $remoteName = 'origin')
    git branch -d "$branchName"
    git push $remoteName --delete "$branchName"
}
Set-Alias gremove Remove-GitBranch

<#
    .Synopsis
    Open Gmaster in path

    .Parameter path
    Path to git repo

    .Example
    gmas .
#>
function Open-GMaster {
    param($path = '.')
    & gmaster --path="$path"
}
Set-Alias gmas Open-GMaster

Export-ModuleMember -Function * -Alias *