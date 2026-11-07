<#
.SYNOPSIS
    Activate the repository's Git hooks for this clone.
.DESCRIPTION
    Sets core.hooksPath to .githooks. This is local Git configuration and must
    be repeated for every clone. Run the script from anywhere inside the repo.
#>
[CmdletBinding()]
param()

$root = Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
    if (-not (Test-Path .githooks)) {
        throw ".githooks not found in $root"
    }
    git config core.hooksPath .githooks
    if ($LASTEXITCODE -ne 0) {
        throw "git config core.hooksPath failed"
    }
    Write-Output "core.hooksPath = $(git config --get core.hooksPath)"
}
finally {
    Pop-Location
}
