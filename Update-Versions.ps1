# This script is to update versions in version.json, and create PR(s) for each bumped version
# It may be run manually or as a cron
[CmdletBinding()]
param (
    [Parameter(HelpMessage="Whether to perform a dry run (skip writing versions.json)")]
    [switch]$DryRun
,
    [Parameter(HelpMessage="Whether to open a PR for each updated version in version.json")]
    [switch]$PR
)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

# Install modules
@(
    'Generate-DockerImageVariants'
    'Powershell-Yaml'
    'PowerShellForGitHub'
) | % {
    if (! (Get-Module $_ -ListAvailable) ) {
        Install-Module $_ -Scope CurrentUser -Force
    }
}

$VERSIONS = Get-Content $PSScriptRoot/generate/definitions/versions.json -Encoding utf8 | ConvertFrom-Json -Depth 100

$y = (Invoke-WebRequest https://raw.githubusercontent.com/kubernetes/website/main/data/releases/eol.yaml).Content | ConvertFrom-Yaml
$VERSIONS_EOL = @( $y.branches | % { $_.finalPatchRelease } )
$y = (Invoke-WebRequest https://raw.githubusercontent.com/kubernetes/website/main/data/releases/schedule.yaml).Content | ConvertFrom-Yaml
$VERSIONS_NEW = @( $y.schedules | % { $_.previousPatches[0].release } )

function Create-PR () {
    [CmdletBinding()]
    param (
        [version]$v,
        [version]$vn,
        [ValidateSet('add', 'update')]
        [string]$verb
    )
    if (!(git config --global --get user.name)) {
        git config --global user.name "The Oh Brothers Bot"
    }
    if (!(git config --global --get user.email)) {
        git config --global user.email "bot@theohbrothers.com"
    }
    git checkout master
    Generate-DockerImageVariants .
    $BRANCH = if ($verb -eq 'add') {
        "enhancement/add-v$( $vn.Major ).$( $vn.Minor ).$( $vn.Build )-variants"
    }elseif ($verb -eq 'update') {
        "enhancement/bump-v$( $v.Major ).$( $v.Minor )-variants-to-$( $vn )"
    }
    $COMMIT_MSG = if ($verb -eq 'add') {
        @"
Enhancement: Add v$( $vn.Major ).$( $vn.Minor ).$( $vn.Build ) variants

Signed-off-by: $( git config --global user.name ) <$( git config --global --get user.email )>
"@
    }elseif ($verb -eq 'update') {
        @"
Enhancement: Bump v$( $v.Major ).$( $v.Minor ) variants to $( $vn )

Signed-off-by: $( git config --global user.name ) <$( git config --global --get user.email )>
"@
    }
    git checkout -b $BRANCH
    git add .
    git commit -m $COMMIT_MSG
    git push origin $BRANCH -f

    "Creating PR" | Write-Host -ForegroundColor Green
    $env:GITHUB_TOKEN = if ($env:GITHUB_TOKEN) { $env:GITHUB_TOKEN } else { (Get-Content ~/.git-credentials -Encoding utf8 -Force) -split "`n" | % { if ($_ -match '^https://[^:]+:([^:]+)@github.com') { $matches[1] } } | Select-Object -First 1 }
    $owner = (git remote get-url origin) -replace 'https://github.com/([^/]+)/([^/]+)', '$1'
    $project = (git remote get-url origin) -replace 'https://github.com/([^/]+)/([^/]+)', '$2' -replace '\.git$', ''
    $milestoneTitle = 'next-release'
    Set-GitHubConfiguration -DisableTelemetry
    Set-GitHubConfiguration -DisableUpdateCheck
    if (!(Get-GitHubMilestone -OwnerName $owner -RepositoryName $project -AccessToken $env:GITHUB_TOKEN | ? { $_.title -eq $milestoneTitle })) {
        New-GitHubMilestone -OwnerName $owner -RepositoryName $project -AccessToken $env:GITHUB_TOKEN -Title $milestoneTitle -State open
    }
    # if (!(gh milestone list --state open --query $MILESTONE --json title --jq '.[] | .title')) {
    #     gh milestone create --title $MILESTONE
    # }
    $pr = Get-GitHubPullRequest -OwnerName $owner -RepositoryName $project -AccessToken $env:GITHUB_TOKEN -State open | ? { $_.base.ref -eq 'master'  -and $_.head.ref -eq $BRANCH }
    if (!$pr) {
        $pr = New-GitHubPullRequest -OwnerName $owner -RepositoryName $project -AccessToken $env:GITHUB_TOKEN -Base master -Head $BRANCH -Title "$( git log --format="%s" -1)" -Body "$( git log --format="%b" -1)"
    }
    Update-GitHubIssue -OwnerName $owner -RepositoryName $project -AccessToken $env:GITHUB_TOKEN -Issue $pr.number -Label enhancement
    # gh pr create --head $BRANCH --fill --label enhancement --milestone $milestoneTitle --repo "$( git remote get-url origin )"
}

function Update-Versions ($VERSIONS, $VERSIONS_NEW, $DryRun, $PR) {
    for ($i = 0; $i -lt $VERSIONS.Length; $i++) {
        $v = [version]$VERSIONS[$i]
        foreach ($vn in $VERSIONS_NEW) {
            $vn = [version]$vn
            if ($i -eq 0 -and $v.Major -lt $vn.Major) {
                "Adding new major version: $vn" | Write-Host -ForegroundColor Green
                if (!$DryRun) {
                    $VERSIONS_CLONE = @( $vn.ToString() ) + $VERSIONS.Clone()
                    $VERSIONS_CLONE | Sort-Object { [version]$_ } -Descending | ConvertTo-Json -Depth 100 | Set-Content $PSScriptRoot/generate/definitions/versions.json -Encoding utf8
                    if ($PR) {
                        Create-PR $v $vn 'add'
                    }
                }
            }elseif ($i -eq 0 -and $v.Major -eq $vn.Major -and $v.Minor -lt $vn.Minor) {
                "Adding new minor version: $vn" | Write-Host -ForegroundColor Green
                if (!$DryRun) {
                    $VERSIONS_CLONE = @( $vn.ToString() ) + $VERSIONS.Clone()
                    $VERSIONS_CLONE | Sort-Object { [version]$_ } -Descending | ConvertTo-Json -Depth 100 | Set-Content $PSScriptRoot/generate/definitions/versions.json -Encoding utf8
                    if ($PR) {
                        Create-PR $v $vn 'add'
                    }
                }
            }elseif ($v.Major -eq $vn.Major -and $v.Minor -eq $vn.Minor -and $v.Build -lt $vn.Build) {
                "Updating patch version: $v to $vn" | Write-Host -ForegroundColor Green
                if (!$DryRun) {
                    $VERSIONS_CLONE = $VERSIONS.Clone()
                    $VERSIONS_CLONE[$i] = $vn.ToString()
                    $VERSIONS_CLONE | Sort-Object { [version]$_ } -Descending | ConvertTo-Json -Depth 100 | Set-Content $PSScriptRoot/generate/definitions/versions.json -Encoding utf8
                    if ($PR) {
                        Create-PR $v $vn 'update'
                    }
                }
            }
        }
    }
}

Update-Versions $VERSIONS $VERSIONS_NEW $DryRun $PR
Update-Versions $VERSIONS $VERSIONS_EOL $DryRun $PR
